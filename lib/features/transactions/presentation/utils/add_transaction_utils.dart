import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_state.dart';

/// Utility class for add transaction form operations.
/// This class provides helper methods for form validation and data formatting.
///
/// Usage Example:
/// ```dart
/// final utils = AddTransactionUtils();
///
/// // Check if form is valid
/// final isValid = utils.isFormValid(state);
///
/// // Format amount for display
/// final formattedAmount = utils.formatAmount(state.amount, state.type);
///
/// // Get current transaction entity
/// final transaction = utils.getCurrentTransaction(state);
/// ```
class AddTransactionUtils {
  /// Checks if the form is valid and ready to submit.
  /// This method validates that all required fields are filled.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [bool]: True if the form is valid, false otherwise
  ///
  /// This method checks:
  /// - Amount is not zero
  /// - Category is selected
  /// - Subcategory is selected
  /// - Date and time is set
  bool isFormValid(AddTransactionMainState state) {
    return state.amount != 0 &&
        state.selectedCategory.isNotEmpty &&
        state.selectedSubcategory.isNotEmpty &&
        state.dateTime != null;
  }

  /// Gets the formatted amount string for display.
  /// This method formats the amount with proper currency formatting.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [type]: The transaction type (expense or income)
  ///
  /// Returns:
  /// - [String]: Formatted amount string
  ///
  /// Example:
  /// - For expense: "-$25.50"
  /// - For income: "$25.50"
  String formatAmount(double amount, TransactionType type) {
    if (amount == 0) return '\$0.00';
    final sign = type == TransactionType.expense ? '-' : '';
    return '$sign\$${amount.abs().toStringAsFixed(2)}';
  }

  /// Gets the formatted date string for display.
  /// This method formats the date and time for display in the UI.
  ///
  /// Parameters:
  /// - [dateTime]: The date and time to format
  ///
  /// Returns:
  /// - [String]: Formatted date string or empty string if not set
  ///
  /// Example: "Jan 15, 2024 at 2:30 PM"
  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return '${dateTime.month}/${dateTime.day}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Checks if the form has any data entered.
  /// This method determines if the user has started entering data.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [bool]: True if the form has data, false otherwise
  bool hasFormData(AddTransactionMainState state) {
    return state.amount != 0 ||
        state.selectedCategory.isNotEmpty ||
        state.selectedSubcategory.isNotEmpty ||
        (state.description?.isNotEmpty ?? false) ||
        state.dateTime != null ||
        (state.merchant?.isNotEmpty ?? false);
  }

  /// Gets the current transaction entity based on form data.
  /// This method creates a transaction entity from the current form state.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [TransactionEntity?]: Transaction entity or null if form is not valid
  TransactionEntity? getCurrentTransaction(AddTransactionMainState state) {
    if (!isFormValid(state)) return null;

    return TransactionEntity(
      id: state.editingTransactionId ?? '',
      amount: state.amount,
      category: state.selectedCategory,
      subcategory: state.selectedSubcategory,
      description: state.description,
      dateTime: state.dateTime!,
      type: state.type,
      merchant: state.merchant,
    );
  }

  /// Validates the transaction amount.
  /// This method checks if the amount is valid for the given transaction type.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [type]: The transaction type
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  String? validateAmount(double amount, TransactionType type) {
    if (amount == 0) {
      return 'Amount cannot be zero';
    }

    if (amount.abs() > 1000000) {
      return 'Amount is too large (maximum: \$1,000,000)';
    }

    if (amount.abs() < 0.01) {
      return 'Amount is too small (minimum: \$0.01)';
    }

    if (type == TransactionType.income && amount < 0) {
      return 'Income transactions must have positive amounts';
    }

    if (type == TransactionType.expense && amount > 0) {
      return 'Expense transactions must have negative amounts';
    }

    return null;
  }

  /// Validates the selected category.
  /// This method checks if a category is selected.
  ///
  /// Parameters:
  /// - [category]: The selected category
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  String? validateCategory(String category) {
    if (category.trim().isEmpty) {
      return 'Please select a category';
    }
    return null;
  }

  /// Validates the selected subcategory.
  /// This method checks if a subcategory is selected.
  ///
  /// Parameters:
  /// - [subcategory]: The selected subcategory
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  String? validateSubcategory(String subcategory) {
    if (subcategory.trim().isEmpty) {
      return 'Please select a subcategory';
    }
    return null;
  }

  /// Validates the transaction date.
  /// This method checks if the date is valid and within acceptable ranges.
  ///
  /// Parameters:
  /// - [dateTime]: The transaction date
  ///
  /// Returns:
  /// - [String?]: Validation error message or null if valid
  String? validateDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Please select a date and time';
    }

    final now = DateTime.now();
    final oneYearAgo = now.subtract(const Duration(days: 365));
    final oneDayFromNow = now.add(const Duration(days: 1));

    if (dateTime.isBefore(oneYearAgo)) {
      return 'Date cannot be more than 1 year in the past';
    }

    if (dateTime.isAfter(oneDayFromNow)) {
      return 'Date cannot be more than 1 day in the future';
    }

    return null;
  }

  /// Gets all validation errors for the current form state.
  /// This method collects all validation errors into a single list.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [List<String>]: List of validation error messages
  List<String> getValidationErrors(AddTransactionMainState state) {
    final errors = <String>[];

    final amountError = validateAmount(state.amount, state.type);
    if (amountError != null) errors.add(amountError);

    final categoryError = validateCategory(state.selectedCategory);
    if (categoryError != null) errors.add(categoryError);

    final subcategoryError = validateSubcategory(state.selectedSubcategory);
    if (subcategoryError != null) errors.add(subcategoryError);

    final dateError = validateDate(state.dateTime);
    if (dateError != null) errors.add(dateError);

    return errors;
  }

  /// Checks if the form can be submitted.
  /// This method determines if the form is ready for submission.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [bool]: True if the form can be submitted, false otherwise
  bool canSubmitForm(AddTransactionMainState state) {
    return isFormValid(state) &&
        getValidationErrors(state).isEmpty &&
        !state.addTransaction.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
  }

  /// Gets the submit button text based on the current state.
  /// This method returns appropriate text for the submit button.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [String]: Submit button text
  String getSubmitButtonText(AddTransactionMainState state) {
    if (state.isEditMode) {
      return 'Update Transaction';
    }
    return 'Add Transaction';
  }

  /// Gets the page title based on the current state.
  /// This method returns appropriate title for the page.
  ///
  /// Parameters:
  /// - [state]: The current add transaction state
  ///
  /// Returns:
  /// - [String]: Page title
  String getPageTitle(AddTransactionMainState state) {
    if (state.isEditMode) {
      return 'Edit Transaction';
    }
    return 'Add Transaction';
  }
}
