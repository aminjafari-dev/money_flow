import 'package:money_flow/features/dashboard/data/models/dashboard_model.dart';

/// Service for calculating dashboard data from transactions.
/// This service handles business logic for financial calculations and aggregations.
///
/// Usage Example:
/// ```dart
/// final calculationService = DashboardCalculationService();
///
/// // Calculate totals from transactions
/// final totals = await calculationService.calculateTotals(transactions);
///
/// // Generate dashboard summary
/// final summary = calculationService.generateDashboardSummary(totals);
/// ```
class DashboardCalculationService {
  /// Creates a new instance of DashboardCalculationService.
  const DashboardCalculationService();

  /// Calculates financial totals from a list of transactions.
  /// This method processes transactions and sums them by category type.
  ///
  /// Parameters:
  /// - [transactions]: List of transaction models to process
  /// - [timeRange]: Optional time range filter (default: all time)
  ///
  /// Returns:
  /// - [Map<String, double>]: Map with category totals and statistics
  ///
  /// Usage Example:
  /// ```dart
  /// final transactions = await getTransactions();
  /// final totals = calculationService.calculateTotals(transactions);
  ///
  /// final income = totals['totalIncome'] ?? 0.0;
  /// final expenses = totals['totalExpenses'] ?? 0.0;
  /// ```
  Map<String, double> calculateTotals(
    List<TransactionModel> transactions, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    // Filter transactions by date range if provided
    final filteredTransactions = _filterTransactionsByDateRange(
      transactions,
      startDate: startDate,
      endDate: endDate,
    );

    // Initialize totals
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    double totalCharity = 0.0;
    double totalInvestments = 0.0;

    // Process each transaction
    for (final transaction in filteredTransactions) {
      final amount = transaction.amount;
      final category = transaction.category.toLowerCase();

      if (amount > 0) {
        // Positive amounts are income
        totalIncome += amount;
      } else {
        // Negative amounts are expenses, categorize by type
        final absAmount = amount.abs();

        if (_isCharityCategory(category)) {
          totalCharity += absAmount;
        } else if (_isInvestmentCategory(category)) {
          totalInvestments += absAmount;
        } else {
          totalExpenses += absAmount;
        }
      }
    }

    // Calculate additional metrics
    final totalSpending = totalExpenses + totalCharity;
    final netWorth = totalIncome + totalInvestments - totalSpending;
    final savingsRate = totalIncome > 0
        ? (totalInvestments / totalIncome) * 100
        : 0.0;

    return {
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'totalCharity': totalCharity,
      'totalInvestments': totalInvestments,
      'totalSpending': totalSpending,
      'netWorth': netWorth,
      'savingsRate': savingsRate,
    };
  }

  /// Generates a dashboard summary with calculated metrics.
  /// This method creates a comprehensive financial overview.
  ///
  /// Parameters:
  /// - [totals]: Map containing calculated financial totals
  ///
  /// Returns:
  /// - [Map<String, dynamic>]: Dashboard summary with metrics and insights
  ///
  /// Usage Example:
  /// ```dart
  /// final totals = calculationService.calculateTotals(transactions);
  /// final summary = calculationService.generateDashboardSummary(totals);
  ///
  /// final isHealthy = summary['isFinanciallyHealthy'] as bool;
  /// final insights = summary['insights'] as List<String>;
  /// ```
  Map<String, dynamic> generateDashboardSummary(Map<String, double> totals) {
    final totalIncome = totals['totalIncome'] ?? 0.0;
    final totalExpenses = totals['totalExpenses'] ?? 0.0;
    final totalCharity = totals['totalCharity'] ?? 0.0;
    final totalInvestments = totals['totalInvestments'] ?? 0.0;
    final netWorth = totals['netWorth'] ?? 0.0;
    final savingsRate = totals['savingsRate'] ?? 0.0;

    // Generate insights
    final insights = <String>[];

    if (savingsRate >= 20.0) {
      insights.add('Great job! You\'re saving more than 20% of your income.');
    } else if (savingsRate >= 10.0) {
      insights.add('Good progress! You\'re saving 10% or more of your income.');
    } else {
      insights.add('Consider increasing your savings rate to build wealth.');
    }

    if (totalCharity > 0) {
      final charityRate = totalIncome > 0
          ? (totalCharity / totalIncome) * 100
          : 0.0;
      if (charityRate >= 10.0) {
        insights.add('Excellent! You\'re giving more than 10% to charity.');
      } else {
        insights.add('Consider increasing your charitable giving.');
      }
    }

    if (netWorth > 0) {
      insights.add('Your net worth is positive. Keep up the good work!');
    } else {
      insights.add('Focus on reducing expenses and increasing savings.');
    }

    // Determine financial health status
    final isFinanciallyHealthy = _determineFinancialHealth(
      totalIncome,
      totalExpenses,
      totalCharity,
      totalInvestments,
      savingsRate,
    );

    return {
      'totals': totals,
      'insights': insights,
      'isFinanciallyHealthy': isFinanciallyHealthy,
      'recommendations': _generateRecommendations(totals),
      'goalProgress': _calculateGoalProgress(totals),
    };
  }

  /// Filters transactions by date range.
  /// This method helps with time-based analysis and reporting.
  ///
  /// Parameters:
  /// - [transactions]: List of transactions to filter
  /// - [startDate]: Optional start date filter
  /// - [endDate]: Optional end date filter
  ///
  /// Returns:
  /// - [List<TransactionModel>]: Filtered list of transactions
  ///
  /// Usage Example:
  /// ```dart
  /// final startDate = DateTime.now().subtract(const Duration(days: 30));
  /// final endDate = DateTime.now();
  ///
  /// final monthlyTransactions = calculationService.filterTransactionsByDateRange(
  ///   transactions,
  ///   startDate: startDate,
  ///   endDate: endDate,
  /// );
  /// ```
  List<TransactionModel> filterTransactionsByDateRange(
    List<TransactionModel> transactions, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _filterTransactionsByDateRange(
      transactions,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// Private method to filter transactions by date range.
  /// This method handles the actual filtering logic.
  ///
  /// Parameters:
  /// - [transactions]: List of transactions to filter
  /// - [startDate]: Optional start date filter
  /// - [endDate]: Optional end date filter
  ///
  /// Returns:
  /// - [List<TransactionModel>]: Filtered list of transactions
  List<TransactionModel> _filterTransactionsByDateRange(
    List<TransactionModel> transactions, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    if (startDate == null && endDate == null) {
      return transactions;
    }

    return transactions.where((transaction) {
      final transactionDate = transaction.date;

      if (startDate != null && transactionDate.isBefore(startDate)) {
        return false;
      }

      if (endDate != null && transactionDate.isAfter(endDate)) {
        return false;
      }

      return true;
    }).toList();
  }

  /// Determines if a category is charity-related.
  /// This method helps categorize transactions correctly.
  ///
  /// Parameters:
  /// - [category]: Category name to check
  ///
  /// Returns:
  /// - [bool]: True if category is charity-related
  bool _isCharityCategory(String category) {
    final charityKeywords = ['charity', 'donation', 'giving', 'fund', 'ngo'];
    return charityKeywords.any((keyword) => category.contains(keyword));
  }

  /// Determines if a category is investment-related.
  /// This method helps categorize transactions correctly.
  ///
  /// Parameters:
  /// - [category]: Category name to check
  ///
  /// Returns:
  /// - [bool]: True if category is investment-related
  bool _isInvestmentCategory(String category) {
    final investmentKeywords = [
      'investment',
      'saving',
      'deposit',
      'fund',
      'stock',
      'bond',
    ];
    return investmentKeywords.any((keyword) => category.contains(keyword));
  }

  /// Determines overall financial health based on metrics.
  /// This method provides a high-level assessment of financial status.
  ///
  /// Parameters:
  /// - [totalIncome]: Total income amount
  /// - [totalExpenses]: Total expenses amount
  /// - [totalCharity]: Total charity amount
  /// - [totalInvestments]: Total investments amount
  /// - [savingsRate]: Savings rate percentage
  ///
  /// Returns:
  /// - [bool]: True if financially healthy
  bool _determineFinancialHealth(
    double totalIncome,
    double totalExpenses,
    double totalCharity,
    double totalInvestments,
    double savingsRate,
  ) {
    // Basic health checks
    if (totalIncome <= 0) return false;

    final totalSpending = totalExpenses + totalCharity;
    if (totalSpending > totalIncome) return false;

    // Savings rate should be at least 10%
    if (savingsRate < 10.0) return false;

    return true;
  }

  /// Generates recommendations based on financial data.
  /// This method provides actionable advice for financial improvement.
  ///
  /// Parameters:
  /// - [totals]: Map containing financial totals
  ///
  /// Returns:
  /// - [List<String>]: List of recommendations
  List<String> _generateRecommendations(Map<String, double> totals) {
    final recommendations = <String>[];
    final totalIncome = totals['totalIncome'] ?? 0.0;
    final totalExpenses = totals['totalExpenses'] ?? 0.0;
    final totalCharity = totals['totalCharity'] ?? 0.0;
    final totalInvestments = totals['totalInvestments'] ?? 0.0;
    final savingsRate = totals['savingsRate'] ?? 0.0;

    if (savingsRate < 10.0) {
      recommendations.add(
        'Consider increasing your savings rate to at least 10% of income.',
      );
    }

    if (totalCharity == 0.0) {
      recommendations.add(
        'Consider setting aside some money for charitable giving.',
      );
    }

    if (totalExpenses > totalIncome * 0.7) {
      recommendations.add('Try to reduce expenses to below 70% of income.');
    }

    if (totalInvestments == 0.0) {
      recommendations.add('Start investing to build long-term wealth.');
    }

    return recommendations;
  }

  /// Calculates progress toward common financial goals.
  /// This method provides goal-based insights and progress tracking.
  ///
  /// Parameters:
  /// - [totals]: Map containing financial totals
  ///
  /// Returns:
  /// - [Map<String, double>]: Goal progress percentages
  Map<String, double> _calculateGoalProgress(Map<String, double> totals) {
    final totalIncome = totals['totalIncome'] ?? 0.0;
    final totalExpenses = totals['totalExpenses'] ?? 0.0;
    final totalCharity = totals['totalCharity'] ?? 0.0;
    final totalInvestments = totals['totalInvestments'] ?? 0.0;

    // Common financial goals (as percentages of income)
    const double targetSavingsRate = 20.0; // 20% savings goal
    const double targetCharityRate = 10.0; // 10% charity goal
    const double targetExpenseRate = 70.0; // 70% expense limit

    final actualSavingsRate = totalIncome > 0
        ? (totalInvestments / totalIncome) * 100
        : 0.0;
    final actualCharityRate = totalIncome > 0
        ? (totalCharity / totalIncome) * 100
        : 0.0;
    final actualExpenseRate = totalIncome > 0
        ? (totalExpenses / totalIncome) * 100
        : 0.0;

    return {
      'savingsGoalProgress': (actualSavingsRate / targetSavingsRate) * 100,
      'charityGoalProgress': (actualCharityRate / targetCharityRate) * 100,
      'expenseGoalProgress': (targetExpenseRate / actualExpenseRate) * 100,
    };
  }
}
