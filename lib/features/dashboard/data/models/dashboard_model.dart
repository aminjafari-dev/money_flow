import 'package:hive/hive.dart';
import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';

part 'dashboard_model.g.dart';

/// Data model for dashboard information with JSON serialization support.
/// This model handles data transformation between API responses and domain entities.
///
/// Usage Example:
/// ```dart
/// // From JSON
/// final dashboardModel = DashboardModel.fromJson(jsonData);
/// final dashboardEntity = dashboardModel.toDomain();
///
/// // To JSON
/// final jsonData = dashboardModel.toJson();
/// ```
@HiveType(typeId: 0)
class DashboardModel {
  @HiveField(0)
  final double totalIncome;

  @HiveField(1)
  final double totalExpenses;

  @HiveField(2)
  final double totalCharity;

  @HiveField(3)
  final double totalInvestments;

  @HiveField(4)
  final List<TransactionModel> recentTransactions;

  const DashboardModel({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalCharity,
    required this.totalInvestments,
    required this.recentTransactions,
  });

  /// Creates a DashboardModel from JSON data.
  /// This method handles API response parsing and data validation.
  ///
  /// Parameters:
  /// - [json]: Map containing dashboard data from API response
  ///
  /// Returns:
  /// - [DashboardModel]: Parsed dashboard model instance
  ///
  /// Usage Example:
  /// ```dart
  /// final apiResponse = await apiClient.get('/dashboard');
  /// final dashboardModel = DashboardModel.fromJson(apiResponse.data);
  /// ```
  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalIncome: _parseDouble(json['total_income']),
      totalExpenses: _parseDouble(json['total_expenses']),
      totalCharity: _parseDouble(json['total_charity']),
      totalInvestments: _parseDouble(json['total_investments']),
      recentTransactions:
          (json['recent_transactions'] as List<dynamic>?)
              ?.map(
                (transactionJson) => TransactionModel.fromJson(transactionJson),
              )
              .toList() ??
          [],
    );
  }

  /// Converts DashboardModel to JSON format.
  /// This method prepares data for API requests or local storage.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of dashboard data
  ///
  /// Usage Example:
  /// ```dart
  /// final dashboardModel = DashboardModel(...);
  /// final jsonData = dashboardModel.toJson();
  /// await apiClient.post('/dashboard', data: jsonData);
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'total_income': totalIncome,
      'total_expenses': totalExpenses,
      'total_charity': totalCharity,
      'total_investments': totalInvestments,
      'recent_transactions': recentTransactions
          .map((transaction) => transaction.toJson())
          .toList(),
    };
  }

  /// Creates a DashboardModel from domain entity.
  /// This method is used when converting from business logic to data layer.
  ///
  /// Parameters:
  /// - [entity]: DashboardEntity from domain layer
  ///
  /// Returns:
  /// - [DashboardModel]: Data model representation
  ///
  /// Usage Example:
  /// ```dart
  /// final dashboardEntity = DashboardEntity(...);
  /// final dashboardModel = DashboardModel.fromEntity(dashboardEntity);
  /// ```
  factory DashboardModel.fromEntity(DashboardEntity entity) {
    return DashboardModel(
      totalIncome: entity.totalIncome,
      totalExpenses: entity.totalExpenses,
      totalCharity: entity.totalCharity,
      totalInvestments: entity.totalInvestments,
      recentTransactions: entity.recentTransactions
          .map((transaction) => TransactionModel.fromEntity(transaction))
          .toList(),
    );
  }

  /// Converts DashboardModel to domain entity.
  /// This method bridges the data layer with domain layer.
  ///
  /// Returns:
  /// - [DashboardEntity]: Pure business object for domain layer
  ///
  /// Usage Example:
  /// ```dart
  /// final dashboardModel = DashboardModel.fromJson(jsonData);
  /// final dashboardEntity = dashboardModel.toDomain();
  /// // Use entity in business logic without data layer concerns
  /// ```
  DashboardEntity toDomain() {
    return DashboardEntity(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalCharity: totalCharity,
      totalInvestments: totalInvestments,
      recentTransactions: recentTransactions
          .map((transaction) => transaction.toDomain())
          .toList(),
    );
  }

  /// Safely parses double values from JSON.
  /// This method handles null values and type conversion errors.
  ///
  /// Parameters:
  /// - [value]: Dynamic value from JSON
  ///
  /// Returns:
  /// - [double]: Parsed double value or 0.0 if parsing fails
  ///
  /// This is useful for handling inconsistent API responses where
  /// numeric values might be null or in different formats.
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  @override
  String toString() {
    return 'DashboardModel{totalIncome: $totalIncome, totalExpenses: $totalExpenses, totalCharity: $totalCharity, totalInvestments: $totalInvestments, recentTransactions: ${recentTransactions.length} items}';
  }
}

/// Data model for transaction information with JSON serialization support.
/// This model handles individual transaction data transformation.
///
/// Usage Example:
/// ```dart
/// // From JSON
/// final transactionModel = TransactionModel.fromJson(jsonData);
/// final transactionEntity = transactionModel.toDomain();
///
/// // To JSON
/// final jsonData = transactionModel.toJson();
/// ```
@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final DateTime date;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  /// Creates a TransactionModel from JSON data.
  /// This method handles API response parsing for individual transactions.
  ///
  /// Parameters:
  /// - [json]: Map containing transaction data from API response
  ///
  /// Returns:
  /// - [TransactionModel]: Parsed transaction model instance
  ///
  /// Usage Example:
  /// ```dart
  /// final apiResponse = await apiClient.get('/transactions/1');
  /// final transactionModel = TransactionModel.fromJson(apiResponse.data);
  /// ```
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      amount: _parseDouble(json['amount']),
      category: json['category']?.toString() ?? '',
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  /// Converts TransactionModel to JSON format.
  /// This method prepares transaction data for API requests.
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: JSON representation of transaction data
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionModel = TransactionModel(...);
  /// final jsonData = transactionModel.toJson();
  /// await apiClient.post('/transactions', data: jsonData);
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  /// Creates a TransactionModel from domain entity.
  /// This method converts from business logic to data layer.
  ///
  /// Parameters:
  /// - [entity]: TransactionEntity from domain layer
  ///
  /// Returns:
  /// - [TransactionModel]: Data model representation
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionEntity = TransactionEntity(...);
  /// final transactionModel = TransactionModel.fromEntity(transactionEntity);
  /// ```
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      category: entity.category,
      date: entity.date,
    );
  }

  /// Converts TransactionModel to domain entity.
  /// This method bridges the data layer with domain layer.
  ///
  /// Returns:
  /// - [TransactionEntity]: Pure business object for domain layer
  ///
  /// Usage Example:
  /// ```dart
  /// final transactionModel = TransactionModel.fromJson(jsonData);
  /// final transactionEntity = transactionModel.toDomain();
  /// // Use entity in business logic without data layer concerns
  /// ```
  TransactionEntity toDomain() {
    return TransactionEntity(
      id: id,
      title: title,
      amount: amount,
      category: category,
      date: date,
    );
  }

  /// Safely parses double values from JSON.
  /// This method handles null values and type conversion errors.
  ///
  /// Parameters:
  /// - [value]: Dynamic value from JSON
  ///
  /// Returns:
  /// - [double]: Parsed double value or 0.0 if parsing fails
  ///
  /// This is useful for handling inconsistent API responses where
  /// numeric values might be null or in different formats.
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  @override
  String toString() {
    return 'TransactionModel{id: $id, title: $title, amount: $amount, category: $category, date: $date}';
  }
}
