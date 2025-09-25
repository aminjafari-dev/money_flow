import 'package:freezed_annotation/freezed_annotation.dart';

part 'sms_category_tracking_entity.freezed.dart';

/// Entity for tracking which SMS messages have been added to which categories.
/// This entity represents the business logic for SMS category tracking
/// and is used throughout the domain layer.
///
/// Usage Example:
/// ```dart
/// final tracking = SmsCategoryTrackingEntity(
///   smsId: 'sms_123',
///   category: 'Income',
///   mainCategory: 'income',
///   addedAt: DateTime.now(),
/// );
/// ```
@freezed
class SmsCategoryTrackingEntity with _$SmsCategoryTrackingEntity {
  /// Creates an SMS category tracking entity with all required fields.
  ///
  /// Parameters:
  /// - [smsId]: Unique identifier for the SMS message
  /// - [category]: The category name (Income, Expenses, Charity, Investments)
  /// - [mainCategory]: The main category (income, expenses, charity, investments)
  /// - [addedAt]: Timestamp when this SMS was added to the category
  /// - [transactionId]: Transaction ID if a transaction was created from this SMS
  const factory SmsCategoryTrackingEntity({
    required String smsId,
    required String category,
    required String mainCategory,
    required DateTime addedAt,
    String? transactionId,
  }) = _SmsCategoryTrackingEntity;
}
