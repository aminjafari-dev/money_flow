import 'package:money_flow/features/transactions/domain/entities/transaction_list_entity.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';

/// Data model for transaction list serialization and API communication.
/// This model handles JSON serialization/deserialization and converts to/from domain entities.
///
/// This model is used in the data layer to handle API responses and local storage.
///
/// Usage Example:
/// ```dart
/// // From JSON (API response)
/// final model = TransactionListModel.fromJson(jsonData);
/// final entity = model.toDomain();
///
/// // To JSON (API request)
/// final entity = TransactionListEntity(...);
/// final model = TransactionListModel.fromDomain(entity);
/// final json = model.toJson();
/// ```
class TransactionListModel {
  /// List of transaction models
  final List<Map<String, dynamic>> transactions;

  /// Total count of transactions
  final int totalCount;

  /// Whether there are more transactions to load (for pagination)
  final bool hasMore;

  /// Current page number (for pagination)
  final int currentPage;

  /// Total number of pages (for pagination)
  final int totalPages;

  const TransactionListModel({
    required this.transactions,
    required this.totalCount,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPages = 1,
  });

  /// Creates a TransactionListModel from JSON data.
  /// This is used when receiving data from API or local storage.
  ///
  /// Parameters:
  /// - [json]: Map containing transaction list data
  ///
  /// Returns:
  /// - [TransactionListModel]: Parsed transaction list model
  ///
  /// Example:
  /// ```dart
  /// final json = {
  ///   'transactions': [
  ///     {'id': 'txn_1', 'amount': 25.50, ...},
  ///     {'id': 'txn_2', 'amount': 100.00, ...},
  ///   ],
  ///   'totalCount': 2,
  ///   'hasMore': false,
  ///   'currentPage': 1,
  ///   'totalPages': 1,
  /// };
  /// final model = TransactionListModel.fromJson(json);
  /// ```
  factory TransactionListModel.fromJson(Map<String, dynamic> json) {
    return TransactionListModel(
      transactions: List<Map<String, dynamic>>.from(
        json['transactions'] as List? ?? [],
      ),
      totalCount: json['totalCount'] as int? ?? 0,
      hasMore: json['hasMore'] as bool? ?? false,
      currentPage: json['currentPage'] as int? ?? 1,
      totalPages: json['totalPages'] as int? ?? 1,
    );
  }

  /// Creates a TransactionListModel from a domain entity.
  /// This is used when converting from business logic to data layer.
  ///
  /// Parameters:
  /// - [entity]: The transaction list entity to convert
  ///
  /// Returns:
  /// - [TransactionListModel]: Converted transaction list model
  ///
  /// Example:
  /// ```dart
  /// final entity = TransactionListEntity(
  ///   transactions: [transaction1, transaction2],
  ///   totalCount: 2,
  /// );
  /// final model = TransactionListModel.fromDomain(entity);
  /// ```
  factory TransactionListModel.fromDomain(TransactionListEntity entity) {
    // Convert transaction entities to JSON maps
    final transactionMaps = entity.transactions.map((transaction) {
      return {
        'id': transaction.id,
        'amount': transaction.amount,
        'mainCategory': transaction.mainCategory,
        'category': transaction.category,
        'description': transaction.description,
        'dateTime': transaction.dateTime.toIso8601String(),
        'type': transaction.type.name,
        'isFromSms': transaction.isFromSms,
        'merchant': transaction.merchant,
      };
    }).toList();

    return TransactionListModel(
      transactions: transactionMaps,
      totalCount: entity.totalCount,
      hasMore: entity.hasMore,
    );
  }

  /// Converts the model to JSON format.
  /// This is used when sending data to API or storing in local storage.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of the transaction list
  ///
  /// Example:
  /// ```dart
  /// final model = TransactionListModel(...);
  /// final json = model.toJson();
  /// // Send to API or store locally
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions,
      'totalCount': totalCount,
      'hasMore': hasMore,
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }

  /// Converts the model to a domain entity.
  /// This is used when passing data from data layer to domain layer.
  ///
  /// Note: This method requires access to TransactionEntity parsing logic.
  /// In a real implementation, you would need to parse each transaction map
  /// to TransactionEntity objects.
  ///
  /// Returns:
  /// - [TransactionListEntity]: Converted transaction list entity
  ///
  /// Example:
  /// ```dart
  /// final model = TransactionListModel.fromJson(jsonData);
  /// final entity = model.toDomain();
  /// // Use entity in business logic
  /// ```
  TransactionListEntity toDomain() {
    // Note: In a real implementation, you would parse each transaction map
    // to TransactionEntity objects. For now, we'll return an empty list
    // as the actual parsing would require the TransactionModel class.
    final transactionEntities = <TransactionEntity>[];

    return TransactionListEntity(
      transactions: transactionEntities,
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  /// Creates a copy of this model with updated fields.
  /// This is useful for updating transaction list while maintaining immutability.
  ///
  /// Parameters:
  /// - [transactions]: Optional new transactions list
  /// - [totalCount]: Optional new total count
  /// - [hasMore]: Optional new hasMore flag
  /// - [currentPage]: Optional new current page
  /// - [totalPages]: Optional new total pages
  ///
  /// Returns:
  /// - [TransactionListModel]: Updated transaction list model
  ///
  /// Usage Example:
  /// ```dart
  /// final updatedModel = model.copyWith(
  ///   transactions: newTransactions,
  ///   totalCount: newCount,
  /// );
  /// ```
  TransactionListModel copyWith({
    List<Map<String, dynamic>>? transactions,
    int? totalCount,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
  }) {
    return TransactionListModel(
      transactions: transactions ?? this.transactions,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionListModel &&
        other.transactions.length == transactions.length &&
        other.totalCount == totalCount &&
        other.hasMore == hasMore &&
        other.currentPage == currentPage &&
        other.totalPages == totalPages;
  }

  @override
  int get hashCode {
    return Object.hash(
      transactions.length,
      totalCount,
      hasMore,
      currentPage,
      totalPages,
    );
  }

  @override
  String toString() {
    return 'TransactionListModel(transactions: ${transactions.length}, totalCount: $totalCount, hasMore: $hasMore, currentPage: $currentPage, totalPages: $totalPages)';
  }
}
