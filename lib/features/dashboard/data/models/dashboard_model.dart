import 'package:money_flow/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:money_flow/shared/models/transaction/transaction_model.dart';

/// Data model for dashboard information with JSON serialization support.
/// This model handles data transformation between API responses and domain entities.
/// Uses shared TransactionModel for consistency across the app.
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
class DashboardModel {
  /// Total income amount for the current period
  final double totalIncome;

  /// Total expenses amount for the current period
  final double totalExpenses;

  /// Total charity donations amount for the current period
  final double totalCharity;

  /// Total investments value for the current period
  final double totalInvestments;

  /// List of recent transactions using shared TransactionModel
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
          .map((transaction) => TransactionModel.fromDomain(transaction))
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
