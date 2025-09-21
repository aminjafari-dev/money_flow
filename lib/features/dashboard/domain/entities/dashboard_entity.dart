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
///       title: 'Fresh Foods Market',
///       amount: -85.50,
///       category: 'Groceries',
///       date: DateTime.now(),
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

/// Transaction entity representing a single financial transaction.
/// This is used within the dashboard to show recent activity.
///
/// Usage Example:
/// ```dart
/// final transaction = TransactionEntity(
///   id: '1',
///   title: 'Fresh Foods Market',
///   amount: -85.50, // Negative for expenses, positive for income
///   category: 'Groceries',
///   date: DateTime.now(),
/// );
/// ```
class TransactionEntity {
  /// Unique identifier for the transaction
  final String id;

  /// Display title/description of the transaction
  final String title;

  /// Transaction amount (negative for expenses, positive for income)
  final double amount;

  /// Category of the transaction (e.g., 'Groceries', 'Salary')
  final String category;

  /// Date when the transaction occurred
  final DateTime date;

  const TransactionEntity({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  /// Check if this is an income transaction
  /// This is useful for UI styling and categorization
  bool get isIncome => amount > 0;

  /// Check if this is an expense transaction
  /// This helps with expense tracking and budgeting
  bool get isExpense => amount < 0;

  /// Get absolute amount for display purposes
  /// This removes the sign for cleaner UI presentation
  double get absoluteAmount => amount.abs();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          amount == other.amount &&
          category == other.category &&
          date == other.date;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      amount.hashCode ^
      category.hashCode ^
      date.hashCode;

  @override
  String toString() {
    return 'TransactionEntity{id: $id, title: $title, amount: $amount, category: $category, date: $date}';
  }
}
