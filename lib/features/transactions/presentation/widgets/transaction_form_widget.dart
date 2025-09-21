import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_bloc.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_event.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_state.dart';
import 'package:money_flow/features/transactions/presentation/utils/add_transaction_utils.dart';
import 'package:money_flow/features/transactions/presentation/widgets/amount_input_widget.dart';
import 'package:money_flow/features/transactions/presentation/widgets/category_selector_widget.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main form widget for adding/editing transactions.
/// This widget provides a comprehensive form interface for transaction entry
/// with all necessary fields and validation.
///
/// Usage Example:
/// ```dart
/// TransactionFormWidget(
///   onTransactionAdded: (transaction) {
///     // Handle successful transaction addition
///     Navigator.of(context).pop();
///   },
/// )
/// ```
class TransactionFormWidget extends StatefulWidget {
  /// Callback when transaction is successfully added
  final ValueChanged<TransactionEntity>? onTransactionAdded;

  /// Callback when form is cancelled
  final VoidCallback? onCancelled;

  /// Whether the form is in edit mode
  final bool isEditMode;

  /// Transaction to edit (if in edit mode)
  final TransactionEntity? transactionToEdit;

  const TransactionFormWidget({
    super.key,
    this.onTransactionAdded,
    this.onCancelled,
    this.isEditMode = false,
    this.transactionToEdit,
  });

  @override
  State<TransactionFormWidget> createState() => _TransactionFormWidgetState();
}

class _TransactionFormWidgetState extends State<TransactionFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _merchantController = TextEditingController();
  final _utils = AddTransactionUtils();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _merchantController.dispose();
    super.dispose();
  }

  /// Initializes the form with default values or existing transaction data.
  /// This method sets up the form based on whether it's in edit mode or not.
  void _initializeForm() {
    if (widget.isEditMode && widget.transactionToEdit != null) {
      final transaction = widget.transactionToEdit!;
      _descriptionController.text = transaction.description ?? '';
      _merchantController.text = transaction.merchant ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTransactionBloc, AddTransactionMainState>(
      listener: (context, state) {
        // Handle transaction addition success
        state.addTransaction.when(
          initial: () {},
          loading: () {},
          completed: (transaction) {
            widget.onTransactionAdded?.call(transaction);
          },
          error: (message) {
            _showErrorSnackBar(message);
          },
        );
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Amount input section
              _buildAmountSection(state),

              GGap.large(),

              // Category selection section
              _buildCategorySection(state),

              GGap.large(),

              // Subcategory selection section
              _buildSubcategorySection(state),

              GGap.large(),

              // Description input section
              _buildDescriptionSection(state),

              GGap.large(),

              // Date and time section
              _buildDateTimeSection(state),

              GGap.large(),

              // Merchant input section
              _buildMerchantSection(state),

              GGap.large(),

              // Action buttons section
              _buildActionButtons(state),
            ],
          ),
        );
      },
    );
  }

  /// Builds the amount input section.
  /// This method creates the amount input widget with transaction type toggle.
  Widget _buildAmountSection(AddTransactionMainState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(Icons.attach_money, color: AppColors.primary, size: 20.0),
            GGap.small(),
            GText(
              'AMOUNT',
              style: AppFonts.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        GGap.medium(),

        // Amount input widget
        AmountInputWidget(
          amount: state.amount,
          onAmountChanged: (amount) {
            context.read<AddTransactionBloc>().add(
              AddTransactionEvent.updateAmount(amount: amount),
            );
          },
          transactionType: state.type,
          enabled: !state.addTransaction.maybeWhen(
            loading: () => true,
            orElse: () => false,
          ),
        ),

        GGap.small(),

        // Transaction type toggle
        _buildTransactionTypeToggle(state),
      ],
    );
  }

  /// Builds the transaction type toggle.
  /// This method creates a toggle for switching between expense and income.
  Widget _buildTransactionTypeToggle(AddTransactionMainState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GText(
          'Type: ',
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        GGap.small(),
        ToggleButtons(
          isSelected: [
            state.type == TransactionType.expense,
            state.type == TransactionType.income,
          ],
          onPressed: (index) {
            final newType = index == 0
                ? TransactionType.expense
                : TransactionType.income;
            context.read<AddTransactionBloc>().add(
              AddTransactionEvent.updateType(type: newType),
            );
          },
          borderRadius: BorderRadius.circular(8.0),
          selectedColor: AppColors.onPrimary,
          fillColor: AppColors.primary,
          color: AppColors.onSurfaceVariant,
          constraints: const BoxConstraints(minHeight: 36.0, minWidth: 80.0),
          children: const [Text('Expense'), Text('Income')],
        ),
      ],
    );
  }

  /// Builds the category selection section.
  /// This method creates the category selector widget.
  Widget _buildCategorySection(AddTransactionMainState state) {
    return state.loadCategories.when(
      initial: () => const SizedBox(),
      loading: () => CategorySelectorWidget(
        categories: const [],
        selectedCategory: state.selectedCategory,
        onCategorySelected: (_) {},
        isLoading: true,
      ),
      completed: (categories) => CategorySelectorWidget(
        categories: categories,
        selectedCategory: state.selectedCategory,
        onCategorySelected: (category) {
          context.read<AddTransactionBloc>().add(
            AddTransactionEvent.updateCategory(category: category),
          );
        },
        enabled: !state.addTransaction.maybeWhen(
          loading: () => true,
          orElse: () => false,
        ),
      ),
      error: (message) => CategorySelectorWidget(
        categories: const [],
        selectedCategory: state.selectedCategory,
        onCategorySelected: (_) {},
        errorMessage: message,
      ),
    );
  }

  /// Builds the subcategory selection section.
  /// This method creates the subcategory selector widget.
  Widget _buildSubcategorySection(AddTransactionMainState state) {
    return state.loadSubcategories.when(
      initial: () => const SizedBox(),
      loading: () => SubcategorySelectorWidget(
        subcategories: const [],
        selectedSubcategory: state.selectedSubcategory,
        onSubcategorySelected: (_) {},
        isLoading: true,
      ),
      completed: (subcategories) => SubcategorySelectorWidget(
        subcategories: subcategories,
        selectedSubcategory: state.selectedSubcategory,
        onSubcategorySelected: (subcategory) {
          context.read<AddTransactionBloc>().add(
            AddTransactionEvent.updateSubcategory(subcategory: subcategory),
          );
        },
        enabled: !state.addTransaction.maybeWhen(
          loading: () => true,
          orElse: () => false,
        ),
      ),
      error: (message) => SubcategorySelectorWidget(
        subcategories: const [],
        selectedSubcategory: state.selectedSubcategory,
        onSubcategorySelected: (_) {},
        errorMessage: message,
      ),
    );
  }

  /// Builds the description input section.
  /// This method creates the description text input field.
  Widget _buildDescriptionSection(AddTransactionMainState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(
              Icons.description_outlined,
              color: AppColors.primary,
              size: 20.0,
            ),
            GGap.small(),
            GText(
              'DESCRIPTION',
              style: AppFonts.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        GGap.medium(),

        // Description input field
        TextFormField(
          controller: _descriptionController,
          enabled: !state.addTransaction.maybeWhen(
            loading: () => true,
            orElse: () => false,
          ),
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'Enter transaction description (optional)',
            hintStyle: AppFonts.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.primary, width: 2.0),
            ),
            contentPadding: const EdgeInsets.all(16.0),
          ),
          style: AppFonts.bodyMedium,
          onChanged: (value) {
            context.read<AddTransactionBloc>().add(
              AddTransactionEvent.updateDescription(
                description: value.isEmpty ? null : value,
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds the date and time section.
  /// This method creates the date and time picker interface.
  Widget _buildDateTimeSection(AddTransactionMainState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: AppColors.primary,
              size: 20.0,
            ),
            GGap.small(),
            GText(
              'DATE & TIME',
              style: AppFonts.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        GGap.medium(),

        // Date and time display/selector
        GestureDetector(
          onTap: () => _selectDateTime(context, state),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.outline),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.onSurfaceVariant,
                  size: 20.0,
                ),
                GGap.small(),
                Expanded(
                  child: GText(
                    state.dateTime != null
                        ? _utils.formatDate(state.dateTime)
                        : 'Select date and time',
                    style: AppFonts.bodyMedium.copyWith(
                      color: state.dateTime != null
                          ? AppColors.onSurface
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: AppColors.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the merchant input section.
  /// This method creates the merchant name input field.
  Widget _buildMerchantSection(AddTransactionMainState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(Icons.store_outlined, color: AppColors.primary, size: 20.0),
            GGap.small(),
            GText(
              'MERCHANT',
              style: AppFonts.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        GGap.medium(),

        // Merchant input field
        TextFormField(
          controller: _merchantController,
          enabled: !state.addTransaction.maybeWhen(
            loading: () => true,
            orElse: () => false,
          ),
          decoration: InputDecoration(
            hintText: 'Enter merchant name (optional)',
            hintStyle: AppFonts.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.primary, width: 2.0),
            ),
            contentPadding: const EdgeInsets.all(16.0),
          ),
          style: AppFonts.bodyMedium,
          onChanged: (value) {
            context.read<AddTransactionBloc>().add(
              AddTransactionEvent.updateMerchant(
                merchant: value.isEmpty ? null : value,
              ),
            );
          },
        ),
      ],
    );
  }

  /// Builds the action buttons section.
  /// This method creates the save and cancel buttons.
  Widget _buildActionButtons(AddTransactionMainState state) {
    final isLoading = state.addTransaction.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final canSubmit = _utils.canSubmitForm(state);

    return Row(
      children: [
        // Cancel button
        Expanded(
          child: GButton(
            text: 'Cancel',
            onPressed: isLoading
                ? null
                : () {
                    widget.onCancelled?.call();
                  },
            variant: GButtonVariant.outlined,
          ),
        ),

        GGap.medium(),

        // Save button
        Expanded(
          child: GButton(
            text: _utils.getSubmitButtonText(state),
            onPressed: canSubmit ? () => _submitForm(state) : null,
            isLoading: isLoading,
            variant: GButtonVariant.filled,
          ),
        ),
      ],
    );
  }

  /// Shows an error snackbar with the given message.
  /// This method displays error messages to the user.
  ///
  /// Parameters:
  /// - [message]: The error message to display
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GText(
          message,
          style: AppFonts.bodyMedium.copyWith(color: AppColors.onError),
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// Selects date and time for the transaction.
  /// This method shows date and time pickers to the user.
  ///
  /// Parameters:
  /// - [context]: The build context
  /// - [state]: The current form state
  Future<void> _selectDateTime(
    BuildContext context,
    AddTransactionMainState state,
  ) async {
    final currentDate = state.dateTime ?? DateTime.now();

    // Select date
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(colorScheme: AppColors.colorScheme),
          child: child!,
        );
      },
    );

    if (selectedDate != null && mounted) {
      // Select time
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
        builder: (context, child) {
          return Theme(
            data: Theme.of(
              context,
            ).copyWith(colorScheme: AppColors.colorScheme),
            child: child!,
          );
        },
      );

      if (selectedTime != null && mounted) {
        final newDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        context.read<AddTransactionBloc>().add(
          AddTransactionEvent.updateDateTime(dateTime: newDateTime),
        );
      }
    }
  }

  /// Submits the form for transaction creation/update.
  /// This method validates the form and submits the transaction.
  ///
  /// Parameters:
  /// - [state]: The current form state
  void _submitForm(AddTransactionMainState state) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate form data
    final validationErrors = _utils.getValidationErrors(state);
    if (validationErrors.isNotEmpty) {
      _showErrorSnackBar(validationErrors.first);
      return;
    }

    // Submit transaction
    context.read<AddTransactionBloc>().add(
      AddTransactionEvent.addTransaction(
        amount: state.amount,
        category: state.selectedCategory,
        subcategory: state.selectedSubcategory,
        description: state.description,
        dateTime: state.dateTime!,
        type: state.type,
        merchant: state.merchant,
      ),
    );
  }
}
