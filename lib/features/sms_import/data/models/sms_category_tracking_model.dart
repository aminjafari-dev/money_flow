import 'package:hive_flutter/hive_flutter.dart';

part 'sms_category_tracking_model.g.dart';

/// Model for tracking which SMS messages have been added to which categories.
/// This model stores the relationship between SMS messages and transaction categories
/// to prevent duplicate transactions and show user which messages have been processed.
///
/// Usage Example:
/// ```dart
/// final tracking = SmsCategoryTrackingModel(
///   smsId: 'sms_123',
///   category: 'Income',
///   mainCategory: 'income',
///   addedAt: DateTime.now(),
/// );
/// ```
@HiveType(typeId: 4)
class SmsCategoryTrackingModel extends HiveObject {
  /// Unique identifier for the SMS message
  @HiveField(0)
  final String smsId;

  /// The category name (Income, Expenses, Charity, Investments)
  @HiveField(1)
  final String category;

  /// The main category (income, expenses, charity, investments)
  @HiveField(2)
  final String mainCategory;

  /// Timestamp when this SMS was added to the category
  @HiveField(3)
  final DateTime addedAt;

  /// Transaction ID if a transaction was created from this SMS
  @HiveField(4)
  final String? transactionId;

  SmsCategoryTrackingModel({
    required this.smsId,
    required this.category,
    required this.mainCategory,
    required this.addedAt,
    this.transactionId,
  });

  /// Creates a copy of this model with updated fields
  SmsCategoryTrackingModel copyWith({
    String? smsId,
    String? category,
    String? mainCategory,
    DateTime? addedAt,
    String? transactionId,
  }) {
    return SmsCategoryTrackingModel(
      smsId: smsId ?? this.smsId,
      category: category ?? this.category,
      mainCategory: mainCategory ?? this.mainCategory,
      addedAt: addedAt ?? this.addedAt,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  /// Converts to JSON for API communication
  Map<String, dynamic> toJson() {
    return {
      'smsId': smsId,
      'category': category,
      'mainCategory': mainCategory,
      'addedAt': addedAt.toIso8601String(),
      'transactionId': transactionId,
    };
  }

  /// Creates from JSON data
  factory SmsCategoryTrackingModel.fromJson(Map<String, dynamic> json) {
    return SmsCategoryTrackingModel(
      smsId: json['smsId'] as String,
      category: json['category'] as String,
      mainCategory: json['mainCategory'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
      transactionId: json['transactionId'] as String?,
    );
  }

  @override
  String toString() {
    return 'SmsCategoryTrackingModel(smsId: $smsId, category: $category, mainCategory: $mainCategory, addedAt: $addedAt, transactionId: $transactionId)';
  }
}
