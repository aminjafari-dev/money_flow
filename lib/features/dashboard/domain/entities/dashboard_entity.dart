import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';

/// Dashboard entity representing the financial overview data.
/// This is a pure business object with no external dependencies.
///
/// Usage Example:
/// ```dart
/// final dashboard = DashboardEntity(
///   totalIncome: 2500.0,
///   totalExpenses: 1200.0,
///   totalCharity: 100.0,
///   totalInvestments: 5000.0,
///   recentTransactions: [
///     TransactionEntity(
///       id: '1',
///       amount: -85.50,
///       category: 'Food',
///       subcategory: 'Groceries',
///       dateTime: DateTime.now(),
///       type: TransactionType.expense,
///     ),
///   ],
/// );
/// ```
class DashboardEntity {
  /// Total income amount for the current period
  final double totalIncome;

  /// Total expenses amount for the current period
  final double totalExpenses;

  /// Total charity donations amount for the current period
  final double totalCharity;

  /// Total investments value for the current period
  final double totalInvestments;

  /// List of recent transactions to display on dashboard
  final List<TransactionEntity> recentTransactions;

  const DashboardEntity({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalCharity,
    required this.totalInvestments,
    required this.recentTransactions,
  });

  /// Calculate net worth (income + investments - expenses - charity)
  /// This is useful for displaying the user's overall financial health
  double get netWorth =>
      totalIncome + totalInvestments - totalExpenses - totalCharity;

  /// Calculate total monthly spending (expenses + charity)
  /// This helps users understand their spending patterns
  double get totalSpending => totalExpenses + totalCharity;

  /// Check if user is within budget (spending < income)
  /// This provides a quick financial health indicator
  bool get isWithinBudget => totalSpending <= totalIncome;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardEntity &&
          runtimeType == other.runtimeType &&
          totalIncome == other.totalIncome &&
          totalExpenses == other.totalExpenses &&
          totalCharity == other.totalCharity &&
          totalInvestments == other.totalInvestments &&
          recentTransactions == other.recentTransactions;

  @override
  int get hashCode =>
      totalIncome.hashCode ^
      totalExpenses.hashCode ^
      totalCharity.hashCode ^
      totalInvestments.hashCode ^
      recentTransactions.hashCode;

  @override
  String toString() {
    return 'DashboardEntity{totalIncome: $totalIncome, totalExpenses: $totalExpenses, totalCharity: $totalCharity, totalInvestments: $totalInvestments, recentTransactions: ${recentTransactions.length} items}';
  }
}
