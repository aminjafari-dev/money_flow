import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_state.dart';

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
  /// - [amount]: The transaction amount
  /// - [category]: The selected category
  /// - [subcategory]: The selected subcategory
  /// - [dateTime]: The transaction date and time
  ///
  /// Returns:
  /// - [bool]: True if the form is valid, false otherwise
  ///
  /// This method checks:
  /// - Amount is not zero
  /// - Category is selected
  /// - Subcategory is selected
  /// - Date and time is set
  bool isFormValid({
    required double amount,
    required String category,
    required String subcategory,
    required DateTime dateTime,
  }) {
    return amount != 0 && category.isNotEmpty && subcategory.isNotEmpty;
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
  /// - [amount]: The transaction amount
  /// - [category]: The selected category
  /// - [subcategory]: The selected subcategory
  /// - [description]: The transaction description
  /// - [dateTime]: The transaction date and time
  /// - [merchant]: The merchant name
  ///
  /// Returns:
  /// - [bool]: True if the form has data, false otherwise
  bool hasFormData({
    required double amount,
    required String category,
    required String subcategory,
    String? description,
    required DateTime dateTime,
    String? merchant,
  }) {
    return amount != 0 ||
        category.isNotEmpty ||
        subcategory.isNotEmpty ||
        (description?.isNotEmpty ?? false) ||
        (merchant?.isNotEmpty ?? false);
  }

  /// Gets the current transaction entity based on form data.
  /// This method creates a transaction entity from the current form data.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [category]: The selected category
  /// - [subcategory]: The selected subcategory
  /// - [description]: The transaction description
  /// - [dateTime]: The transaction date and time
  /// - [type]: The transaction type
  /// - [merchant]: The merchant name
  /// - [id]: Optional transaction ID (for edit mode)
  ///
  /// Returns:
  /// - [TransactionEntity?]: Transaction entity or null if form is not valid
  TransactionEntity? getCurrentTransaction({
    required double amount,
    required String category,
    required String subcategory,
    String? description,
    required DateTime dateTime,
    required TransactionType type,
    String? merchant,
    String? id,
  }) {
    if (!isFormValid(
      amount: amount,
      category: category,
      subcategory: subcategory,
      dateTime: dateTime,
    ))
      return null;

    return TransactionEntity(
      id: id ?? '',
      amount: amount,
      category: category,
      subcategory: subcategory,
      description: description,
      dateTime: dateTime,
      type: type,
      merchant: merchant,
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

  /// Gets all validation errors for the current form data.
  /// This method collects all validation errors into a single list.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [category]: The selected category
  /// - [subcategory]: The selected subcategory
  /// - [dateTime]: The transaction date and time
  /// - [type]: The transaction type
  ///
  /// Returns:
  /// - [List<String>]: List of validation error messages
  List<String> getValidationErrors({
    required double amount,
    required String category,
    required String subcategory,
    required DateTime dateTime,
    required TransactionType type,
  }) {
    final errors = <String>[];

    final amountError = validateAmount(amount, type);
    if (amountError != null) errors.add(amountError);

    final categoryError = validateCategory(category);
    if (categoryError != null) errors.add(categoryError);

    final subcategoryError = validateSubcategory(subcategory);
    if (subcategoryError != null) errors.add(subcategoryError);

    final dateError = validateDate(dateTime);
    if (dateError != null) errors.add(dateError);

    return errors;
  }

  /// Checks if the form can be submitted.
  /// This method determines if the form is ready for submission.
  ///
  /// Parameters:
  /// - [amount]: The transaction amount
  /// - [category]: The selected category
  /// - [subcategory]: The selected subcategory
  /// - [dateTime]: The transaction date and time
  /// - [type]: The transaction type
  /// - [isLoading]: Whether the form is currently loading
  ///
  /// Returns:
  /// - [bool]: True if the form can be submitted, false otherwise
  bool canSubmitForm({
    required double amount,
    required String category,
    required String subcategory,
    required DateTime dateTime,
    required TransactionType type,
    required bool isLoading,
  }) {
    return isFormValid(
          amount: amount,
          category: category,
          subcategory: subcategory,
          dateTime: dateTime,
        ) &&
        getValidationErrors(
          amount: amount,
          category: category,
          subcategory: subcategory,
          dateTime: dateTime,
          type: type,
        ).isEmpty &&
        !isLoading;
  }

  /// Gets the submit button text based on the edit mode.
  /// This method returns appropriate text for the submit button.
  ///
  /// Parameters:
  /// - [isEditMode]: Whether the form is in edit mode
  ///
  /// Returns:
  /// - [String]: Submit button text
  String getSubmitButtonText(bool isEditMode) {
    if (isEditMode) {
      return 'Update Transaction';
    }
    return 'Add Transaction';
  }

  /// Gets the page title based on the edit mode.
  /// This method returns appropriate title for the page.
  ///
  /// Parameters:
  /// - [isEditMode]: Whether the form is in edit mode
  ///
  /// Returns:
  /// - [String]: Page title
  String getPageTitle(bool isEditMode) {
    if (isEditMode) {
      return 'Edit Transaction';
    }
    return 'Add Transaction';
  }
}
