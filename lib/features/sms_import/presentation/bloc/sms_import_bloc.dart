import 'package:bloc/bloc.dart';
import 'package:money_flow/core/constants/no_params.dart';
import 'package:money_flow/features/sms_import/domain/usecases/check_sms_permission_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_conversations_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_messages_by_address_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/request_sms_permission_usecase.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_event.dart';
import 'package:money_flow/features/sms_import/presentation/bloc/sms_import_state.dart';

/// BLoC for managing SMS import-related operations.
/// This BLoC handles all SMS import functionality including loading conversations,
/// loading messages by address, and managing SMS permissions.
///
/// The BLoC follows the event-driven architecture pattern and provides
/// a clean separation between business logic and UI components.
///
/// Usage Example:
/// ```dart
/// BlocProvider(
///   create: (context) => SmsImportBloc(
///     getSmsConversationsUseCase: getIt<GetSmsConversationsUseCase>(),
///     getSmsMessagesByAddressUseCase: getIt<GetSmsMessagesByAddressUseCase>(),
///     checkSmsPermissionUseCase: getIt<CheckSmsPermissionUseCase>(),
///     requestSmsPermissionUseCase: getIt<RequestSmsPermissionUseCase>(),
///   ),
///   child: SmsImportPage(),
/// )
/// ```
class SmsImportBloc extends Bloc<SmsImportEvent, SmsImportState> {
  /// Use case for getting SMS conversations.
  /// This use case handles the business logic for retrieving SMS conversations
  /// grouped by sender address with preview information.
  final GetSmsConversationsUseCase _getSmsConversationsUseCase;

  /// Use case for getting SMS messages by address.
  /// This use case handles the business logic for retrieving SMS messages
  /// from a specific sender address in chronological order.
  final GetSmsMessagesByAddressUseCase _getSmsMessagesByAddressUseCase;

  /// Use case for checking SMS permission.
  /// This use case handles the business logic for verifying SMS read permission
  /// status without requesting permission from the user.
  final CheckSmsPermissionUseCase _checkSmsPermissionUseCase;

  /// Use case for requesting SMS permission.
  /// This use case handles the business logic for requesting SMS read permission
  /// from the user, showing the system permission dialog.
  final RequestSmsPermissionUseCase _requestSmsPermissionUseCase;

  /// Creates a new instance of SmsImportBloc.
  ///
  /// Parameters:
  /// - [getSmsConversationsUseCase]: Use case for getting SMS conversations
  /// - [getSmsMessagesByAddressUseCase]: Use case for getting SMS messages by address
  /// - [checkSmsPermissionUseCase]: Use case for checking SMS permission
  /// - [requestSmsPermissionUseCase]: Use case for requesting SMS permission
  ///
  /// Usage Example:
  /// ```dart
  /// final bloc = SmsImportBloc(
  ///   getSmsConversationsUseCase: getIt<GetSmsConversationsUseCase>(),
  ///   getSmsMessagesByAddressUseCase: getIt<GetSmsMessagesByAddressUseCase>(),
  ///   checkSmsPermissionUseCase: getIt<CheckSmsPermissionUseCase>(),
  ///   requestSmsPermissionUseCase: getIt<RequestSmsPermissionUseCase>(),
  /// );
  /// ```
  SmsImportBloc({
    required GetSmsConversationsUseCase getSmsConversationsUseCase,
    required GetSmsMessagesByAddressUseCase getSmsMessagesByAddressUseCase,
    required CheckSmsPermissionUseCase checkSmsPermissionUseCase,
    required RequestSmsPermissionUseCase requestSmsPermissionUseCase,
  }) : _getSmsConversationsUseCase = getSmsConversationsUseCase,
       _getSmsMessagesByAddressUseCase = getSmsMessagesByAddressUseCase,
       _checkSmsPermissionUseCase = checkSmsPermissionUseCase,
       _requestSmsPermissionUseCase = requestSmsPermissionUseCase,
       super(const SmsImportState()) {
    // Register event handlers
    on<SmsImportEvent>((event, emit) async {
      await event.when(
        loadConversations: () => _onLoadConversations(emit),
        loadMoreConversations: () => _onLoadMoreConversations(emit),
        loadMessagesByAddress: (address) =>
            _onLoadMessagesByAddress(address, emit),
        checkPermission: () => _onCheckPermission(emit),
        requestPermission: () => _onRequestPermission(emit),
        refresh: () => _onRefresh(emit),
        initialize: () => _onInitialize(emit),
      );
    });
  }

  /// Handles the load conversations event.
  /// This method loads all SMS conversations grouped by sender address
  /// and updates the conversations state accordingly.
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onLoadConversations(emit);
  /// ```
  Future<void> _onLoadConversations(Emitter<SmsImportState> emit) async {
    // Check if already loading to prevent duplicate requests
    if (state.conversations is ConversationsLoading) return;

    // Emit loading state
    if (!emit.isDone) {
      emit(state.copyWith(conversations: const ConversationsState.loading()));
    }

    try {
      // Call use case to get conversations with pagination (20 conversations)
      final result = await _getSmsConversationsUseCase.call(
        const GetSmsConversationsParams(limit: 20, offset: 0),
      );

      result.fold(
        // Handle failure case
        (failure) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                conversations: ConversationsState.error(
                  failure.message ?? 'Unknown error',
                ),
              ),
            );
          }
        },
        // Handle success case
        (conversations) {
          if (!emit.isDone) {
            // Determine if there are more conversations to load
            // If we got less than the requested limit, we've reached the end
            final hasMore = conversations.length >= 20;

            emit(
              state.copyWith(
                conversations: ConversationsState.completed(
                  conversations,
                  hasMore,
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            conversations: ConversationsState.error(
              'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  /// Handles the load more conversations event for pagination.
  /// This method loads additional SMS conversations when the user scrolls
  /// to the bottom of the conversations list.
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onLoadMoreConversations(emit);
  /// ```
  Future<void> _onLoadMoreConversations(Emitter<SmsImportState> emit) async {
    // Get current conversations state
    final currentState = state.conversations;

    // Only proceed if we have completed conversations and there are more to load
    if (currentState is! ConversationsCompleted || !currentState.hasMore) {
      return;
    }

    // Check if already loading more to prevent duplicate requests
    if (state.conversations is ConversationsLoadingMore) return;

    // Emit loading more state
    if (!emit.isDone) {
      emit(
        state.copyWith(
          conversations: ConversationsState.loadingMore(
            currentState.conversations,
          ),
        ),
      );
    }

    try {
      // Calculate offset based on current conversations count
      final offset = currentState.conversations.length;

      // Call use case to get more conversations with pagination
      final result = await _getSmsConversationsUseCase.call(
        GetSmsConversationsParams(limit: 20, offset: offset),
      );

      result.fold(
        // Handle failure case
        (failure) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                conversations: ConversationsState.error(
                  failure.message ?? 'Unknown error',
                ),
              ),
            );
          }
        },
        // Handle success case
        (newConversations) {
          if (!emit.isDone) {
            // Combine existing conversations with new ones
            final allConversations = [
              ...currentState.conversations,
              ...newConversations,
            ];

            // Determine if there are more conversations to load
            final hasMore = newConversations.length >= 20;

            emit(
              state.copyWith(
                conversations: ConversationsState.completed(
                  allConversations,
                  hasMore,
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            conversations: ConversationsState.error(
              'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  /// Handles the load messages by address event.
  /// This method loads all SMS messages from a specific sender address
  /// and updates the messages state accordingly.
  ///
  /// Parameters:
  /// - [address]: The sender address to load messages from
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onLoadMessagesByAddress('+1234567890', emit);
  /// ```
  Future<void> _onLoadMessagesByAddress(
    String address,
    Emitter<SmsImportState> emit,
  ) async {
    // Check if already loading to prevent duplicate requests
    if (state.messages is MessagesLoading) return;

    // Emit loading state
    if (!emit.isDone) {
      emit(state.copyWith(messages: const MessagesState.loading()));
    }

    try {
      // Call use case to get messages by address
      final result = await _getSmsMessagesByAddressUseCase.call(
        GetSmsMessagesByAddressParams(address: address),
      );

      result.fold(
        // Handle failure case
        (failure) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                messages: MessagesState.error(
                  failure.message ?? 'Unknown error',
                ),
              ),
            );
          }
        },
        // Handle success case
        (messages) {
          if (!emit.isDone) {
            emit(state.copyWith(messages: MessagesState.completed(messages)));
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            messages: MessagesState.error('Unexpected error: ${e.toString()}'),
          ),
        );
      }
    }
  }

  /// Handles the check permission event.
  /// This method checks the current SMS permission status
  /// and updates the permission state accordingly.
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onCheckPermission(emit);
  /// ```
  Future<void> _onCheckPermission(Emitter<SmsImportState> emit) async {
    // Check if already loading to prevent duplicate requests
    if (state.permission is PermissionLoading) return;

    // Emit loading state
    if (!emit.isDone) {
      emit(state.copyWith(permission: const PermissionState.loading()));
    }

    try {
      // Call use case to check permission
      final result = await _checkSmsPermissionUseCase.call(const NoParams());

      result.fold(
        // Handle failure case
        (failure) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                permission: PermissionState.error(
                  failure.message ?? 'Unknown error',
                ),
              ),
            );
          }
        },
        // Handle success case
        (hasPermission) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                permission: PermissionState.completed(hasPermission),
              ),
            );
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            permission: PermissionState.error(
              'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  /// Handles the request permission event.
  /// This method requests SMS permission from the user
  /// and updates the permission state accordingly.
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onRequestPermission(emit);
  /// ```
  Future<void> _onRequestPermission(Emitter<SmsImportState> emit) async {
    // Check if already loading to prevent duplicate requests
    if (state.permission is PermissionLoading) return;

    // Emit loading state
    if (!emit.isDone) {
      emit(state.copyWith(permission: const PermissionState.loading()));
    }

    try {
      // Call use case to request permission
      final result = await _requestSmsPermissionUseCase.call(const NoParams());

      result.fold(
        // Handle failure case
        (failure) {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                permission: PermissionState.error(
                  failure.message ?? 'Unknown error',
                ),
              ),
            );
          }
        },
        // Handle success case
        (granted) {
          if (!emit.isDone) {
            emit(
              state.copyWith(permission: PermissionState.completed(granted)),
            );
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            permission: PermissionState.error(
              'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  /// Handles the refresh event.
  /// This method refreshes the current SMS data by reloading conversations
  /// and checking permission status.
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onRefresh(emit);
  /// ```
  Future<void> _onRefresh(Emitter<SmsImportState> emit) async {
    // Refresh conversations and permission status
    await _onLoadConversations(emit);
    await _onCheckPermission(emit);
  }

  /// Handles the initialize event.
  /// This method handles the complete SMS import initialization flow:
  /// 1. Check SMS permission
  /// 2. If permission granted, load conversations
  /// 3. If permission denied, request permission
  /// 4. If permission still denied after request, show permission denied state
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _onInitialize(emit);
  /// ```
  Future<void> _onInitialize(Emitter<SmsImportState> emit) async {
    // Emit loading state for permission
    if (!emit.isDone) {
      emit(state.copyWith(permission: const PermissionState.loading()));
    }

    try {
      // Step 1: Check current permission status
      final permissionResult = await _checkSmsPermissionUseCase.call(
        const NoParams(),
      );

      await permissionResult.fold(
        // Handle permission check failure
        (failure) async {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                permission: PermissionState.error(
                  failure.message ?? 'Failed to check SMS permission',
                ),
              ),
            );
          }
        },
        // Handle permission check success
        (hasPermission) async {
          if (!emit.isDone) {
            if (hasPermission) {
              // Permission granted - load conversations
              emit(state.copyWith(permission: PermissionState.completed(true)));
              await _onLoadConversations(emit);
            } else {
              // Permission not granted - request permission
              await _requestPermissionAndHandleResult(emit);
            }
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            permission: PermissionState.error(
              'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    }
  }

  /// Requests SMS permission and handles the result.
  /// This method requests permission from the user and either loads conversations
  /// if granted or shows permission denied state if denied.
  ///
  /// Parameters:
  /// - [emit]: Emitter for state updates
  ///
  /// Usage Example:
  /// ```dart
  /// await _requestPermissionAndHandleResult(emit);
  /// ```
  Future<void> _requestPermissionAndHandleResult(
    Emitter<SmsImportState> emit,
  ) async {
    try {
      // Request permission from user
      final requestResult = await _requestSmsPermissionUseCase.call(
        const NoParams(),
      );

      await requestResult.fold(
        // Handle permission request failure
        (failure) async {
          if (!emit.isDone) {
            emit(
              state.copyWith(
                permission: PermissionState.error(
                  failure.message ?? 'Failed to request SMS permission',
                ),
              ),
            );
          }
        },
        // Handle permission request success
        (granted) async {
          if (!emit.isDone) {
            if (granted) {
              // Permission granted - load conversations
              emit(state.copyWith(permission: PermissionState.completed(true)));
              await _onLoadConversations(emit);
            } else {
              // Permission denied - show permission denied state
              emit(state.copyWith(permission: const PermissionState.denied()));
            }
          }
        },
      );
    } catch (e) {
      // Handle unexpected errors
      if (!emit.isDone) {
        emit(
          state.copyWith(
            permission: PermissionState.error(
              'Unexpected error: ${e.toString()}',
            ),
          ),
        );
      }
    }
  }
}
