import 'package:hive/hive.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

/// Data model for transaction serialization and API communication.
/// This model handles JSON serialization/deserialization and converts to/from domain entities.
/// Also supports Hive local storage for offline functionality.
///
/// Usage Example:
/// ```dart
/// // From JSON (API response)
/// final model = TransactionModel.fromJson(jsonData);
/// final entity = model.toDomain();
///
/// // To JSON (API request)
/// final entity = TransactionEntity(...);
/// final model = TransactionModel.fromDomain(entity);
/// final json = model.toJson();
///
/// // Hive storage
/// final box = Hive.box<TransactionModel>('transactions');
/// await box.put('key', model);
/// ```
@HiveType(typeId: 2)
class TransactionModel {
  /// Unique identifier for the transaction
  @HiveField(0)
  final String id;

  /// Transaction amount (positive for income, negative for expense)
  @HiveField(1)
  final double amount;

  /// Main category of the transaction (income, expenses, charity, investments)
  @HiveField(2)
  final String mainCategory;

  /// Category of the transaction (this is now subcategory)
  @HiveField(3)
  final String category;

  /// Specific subcategory within the main category
  @HiveField(11)
  final String subcategory;

  /// Optional description or notes about the transaction
  @HiveField(4)
  final String? description;

  /// Date and time when the transaction occurred (ISO 8601 string)
  @HiveField(5)
  final String dateTime;

  /// Type of transaction (expense or income)
  @HiveField(6)
  final String type;

  /// Whether this transaction was created from SMS import
  @HiveField(7)
  final bool isFromSms;

  /// Merchant or vendor name
  @HiveField(8)
  final String? merchant;

  /// Timestamp when the transaction was created
  @HiveField(9)
  final String createdAt;

  /// Timestamp when the transaction was last updated
  @HiveField(10)
  final String updatedAt;

  const TransactionModel({
    required this.id,
    required this.amount,
    required this.mainCategory,
    required this.category,
    required this.subcategory,
    this.description,
    required this.dateTime,
    required this.type,
    this.isFromSms = false,
    this.merchant,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a TransactionModel from JSON data.
  /// This is used when receiving data from API or local storage.
  ///
  /// Parameters:
  /// - [json]: Map containing transaction data
  ///
  /// Returns:
  /// - [TransactionModel]: Parsed transaction model
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      mainCategory: json['mainCategory'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      description: json['description'] as String?,
      dateTime: json['dateTime'] as String,
      type: json['type'] as String,
      isFromSms: json['isFromSms'] as bool? ?? false,
      merchant: json['merchant'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  /// Creates a TransactionModel from a domain entity.
  /// This is used when converting from business logic to data layer.
  ///
  /// Parameters:
  /// - [entity]: The transaction entity to convert
  ///
  /// Returns:
  /// - [TransactionModel]: Converted transaction model
  factory TransactionModel.fromDomain(TransactionEntity entity) {
    final now = DateTime.now().toIso8601String();
    return TransactionModel(
      id: entity.id,
      amount: entity.amount,
      mainCategory: entity.mainCategory,
      category: entity.category,
      subcategory: entity.subcategory,
      description: entity.description,
      dateTime: entity.dateTime.toIso8601String(),
      type: entity.type.name,
      isFromSms: entity.isFromSms,
      merchant: entity.merchant,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Converts the model to JSON format.
  /// This is used when sending data to API or storing in local storage.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of the transaction
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'mainCategory': mainCategory,
      'category': category,
      'subcategory': subcategory,
      'description': description,
      'dateTime': dateTime,
      'type': type,
      'isFromSms': isFromSms,
      'merchant': merchant,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  /// Converts the model to a domain entity.
  /// This is used when passing data from data layer to domain layer.
  ///
  /// Returns:
  /// - [TransactionEntity]: Converted transaction entity
  TransactionEntity toDomain() {
    return TransactionEntity(
      id: id,
      amount: amount,
      mainCategory: mainCategory,
      category: category,
      subcategory: subcategory,
      description: description,
      dateTime: DateTime.parse(dateTime),
      type: _parseTransactionType(type),
      isFromSms: isFromSms,
      merchant: merchant,
    );
  }

  /// Creates a copy of this model with updated fields.
  /// This is useful for updating transaction details while maintaining immutability.
  TransactionModel copyWith({
    String? id,
    double? amount,
    String? mainCategory,
    String? category,
    String? subcategory,
    String? description,
    String? dateTime,
    String? type,
    bool? isFromSms,
    String? merchant,
    String? createdAt,
    String? updatedAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      mainCategory: mainCategory ?? this.mainCategory,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isFromSms: isFromSms ?? this.isFromSms,
      merchant: merchant ?? this.merchant,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Parses transaction type string to TransactionType enum.
  /// This handles the conversion from string representation to enum.
  ///
  /// Parameters:
  /// - [typeString]: String representation of transaction type
  ///
  /// Returns:
  /// - [TransactionType]: Parsed transaction type enum
  ///
  /// Throws:
  /// - [FormatException]: If the type string is invalid
  TransactionType _parseTransactionType(String typeString) {
    switch (typeString.toLowerCase()) {
      case 'expense':
        return TransactionType.expense;
      case 'income':
        return TransactionType.income;
      default:
        throw FormatException('Invalid transaction type: $typeString');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionModel &&
        other.id == id &&
        other.amount == amount &&
        other.mainCategory == mainCategory &&
        other.category == category &&
        other.subcategory == subcategory &&
        other.description == description &&
        other.dateTime == dateTime &&
        other.type == type &&
        other.isFromSms == isFromSms &&
        other.merchant == merchant &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      amount,
      mainCategory,
      category,
      subcategory,
      description,
      dateTime,
      type,
      isFromSms,
      merchant,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, mainCategory: $mainCategory, category: $category, subcategory: $subcategory, description: $description, dateTime: $dateTime, type: $type, isFromSms: $isFromSms, merchant: $merchant, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
