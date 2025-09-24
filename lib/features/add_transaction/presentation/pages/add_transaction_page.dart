import 'package:flutter/material.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/services/category_service.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/add_transaction/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_bloc.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_event.dart';
import 'package:money_flow/features/add_transaction/presentation/bloc/add_transaction_state.dart';
import 'package:money_flow/features/add_transaction/presentation/widgets/amount_display_widget.dart';
import 'package:money_flow/features/add_transaction/presentation/widgets/category_selector_widget.dart';
import 'package:money_flow/features/add_transaction/presentation/widgets/transaction_action_buttons_widget.dart';
import 'package:money_flow/features/add_transaction/presentation/widgets/transaction_form_field_widget.dart';
import 'package:money_flow/shared/models/category/category_models.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main page for adding new transactions.
/// This page provides a comprehensive interface for transaction entry
/// with form validation, category selection, and transaction management.
///
/// Usage Example:
/// ```dart
/// Navigator.of(context).push(
///   MaterialPageRoute(
///     builder: (context) => const AddTransactionPage(),
///   ),
/// );
/// ```
class AddTransactionPage extends StatefulWidget {
  /// Transaction to edit (if in edit mode)
  final TransactionEntity? transactionToEdit;

  /// Whether the page is in edit mode
  final bool isEditMode;

  const AddTransactionPage({
    super.key,
    this.transactionToEdit,
    this.isEditMode = false,
  });

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  // Local form state management
  String selectedCategory = '';
  double amount = 0.0;
  DateTime dateTime = DateTime.now();
  TransactionType type = TransactionType.expense;

  // Category management
  List<CategoryModel> availableCategories = [];
  bool isLoadingCategories = true;
  String? categoryError;

  @override
  void initState() {
    super.initState();
    // Set default date time
    _dateTimeController.text = _formatDateTime(DateTime.now());
    // Load categories from CategoryService
    _loadCategories();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Loads categories from CategoryService.
  /// This method fetches the 4 main categories (Income, Expenses, Charity, Investments)
  /// and updates the UI state accordingly.
  Future<void> _loadCategories() async {
    try {
      setState(() {
        isLoadingCategories = true;
        categoryError = null;
      });

      final categoryService = getIt<CategoryService>();
      final categories = await categoryService.getMainCategories();

      if (mounted) {
        setState(() {
          availableCategories = categories;
          isLoadingCategories = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          categoryError = 'Failed to load categories: $e';
          isLoadingCategories = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocConsumer<AddTransactionBloc, AddTransactionMainState>(
      bloc: getIt<AddTransactionBloc>(),
      listener: (context, state) {
        // Handle transaction addition success
        state.addTransaction.when(
          initial: () {},
          loading: () {},
          completed: (transaction) {
            _showSuccessSnackBar(l10n.transactionAddedSuccessfully);
            // Return the transaction to trigger dashboard refresh
            Navigator.of(context).pop(transaction);
          },
          error: (message) {
            _showErrorSnackBar(message);
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildSimpleAppBar(context, l10n),
          body: _buildSimpleBody(context, state, l10n),
        );
      },
    );
  }

  /// Builds a simple app bar matching the design image.
  /// This method creates a minimal app bar with just close button and title.
  PreferredSizeWidget _buildSimpleAppBar(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: GText(
        l10n.addTransactionPageTitle,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Builds the simple body matching the design image.
  /// This creates a clean, minimal interface with large amount display,
  /// category chips, and simple form fields.
  Widget _buildSimpleBody(
    BuildContext context,
    AddTransactionMainState state,
    AppLocalizations l10n,
  ) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Check if keyboard is visible
          final isKeyboardVisible =
              MediaQuery.of(context).viewInsets.bottom > 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 40, // Account for padding
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Large amount display at top
                    _buildAmountDisplay(state),

                    const SizedBox(height: 40),

                    // Category section
                    _buildCategorySection(state, l10n),

                    const SizedBox(height: 30),

                    // Description field
                    _buildDescriptionField(l10n),

                    const SizedBox(height: 20),

                    // Date & Time field
                    _buildDateTimeField(l10n),

                    // Flexible spacer that adjusts based on keyboard visibility
                    if (!isKeyboardVisible)
                      Expanded(child: SizedBox(height: 40))
                    else
                      const SizedBox(height: 40),

                    // Action buttons at bottom
                    _buildActionButtons(context, state, l10n),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds the large amount display at the top of the form.
  /// This shows the current transaction amount in a large, prominent format.
  Widget _buildAmountDisplay(AddTransactionMainState state) {
    return AmountDisplayWidget(
      amount: amount,
      onAmountChanged: (newAmount) {
        setState(() {
          amount = newAmount;
        });
      },
    );
  }

  /// Builds the category selection section with horizontal chips.
  /// This shows the 4 main categories (Income, Expenses, Charity, Investments) as selectable chips.
  Widget _buildCategorySection(
    AddTransactionMainState state,
    AppLocalizations l10n,
  ) {
    // Convert CategoryModel list to String list for the widget
    final categoryNames = availableCategories.map((cat) => cat.name).toList();

    return CategorySelectorWidget(
      categories: categoryNames,
      selectedCategory: selectedCategory,
      onCategorySelected: (category) => _selectCategory(context, category),
      isLoading: isLoadingCategories,
      errorMessage: categoryError,
      l10n: l10n,
    );
  }

  /// Builds the description input field.
  /// This creates a simple text field for transaction description.
  Widget _buildDescriptionField(AppLocalizations l10n) {
    return TransactionFormFieldWidget(
      controller: _descriptionController,
      labelText: l10n.description,
      hintText: l10n.enterDescription,
      onChanged: (value) {
        // Description is managed by the TextEditingController
        // No need to update BLoC state
      },
    );
  }

  /// Builds the date and time input field.
  /// This creates a simple text field for transaction date and time.
  Widget _buildDateTimeField(AppLocalizations l10n) {
    return TransactionFormFieldWidget(
      controller: _dateTimeController,
      labelText: l10n.dateTime,
      hintText: l10n.selectDateTime,
      readOnly: true,
      suffixIcon: const Icon(Icons.calendar_today),
      onTap: () => _selectDateTime(context),
    );
  }

  /// Builds the action buttons at the bottom of the form.
  /// This creates Cancel and Save buttons.
  Widget _buildActionButtons(
    BuildContext context,
    AddTransactionMainState state,
    AppLocalizations l10n,
  ) {
    final isLoading = state.addTransaction.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final canSave =
        selectedCategory.isNotEmpty && amount != 0 && !isLoadingCategories;

    return TransactionActionButtonsWidget(
      onCancel: () => Navigator.of(context).pop(),
      onSave: () => _saveTransaction(context, state),
      isLoading: isLoading,
      canSave: canSave,
      cancelText: l10n.cancel,
      saveText: l10n.save,
    );
  }

  /// Shows success snackbar message.
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GText(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Shows error snackbar message.
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GText(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Selects a category.
  /// This method updates the selected category and determines the transaction type
  /// based on the category selection.
  void _selectCategory(BuildContext context, String category) {
    setState(() {
      selectedCategory = category;
      // Determine transaction type based on category
      switch (category) {
        case 'Income':
          type = TransactionType.income;
          break;
        case 'Expenses':
          type = TransactionType.expense;
          break;
        case 'Charity':
          type = TransactionType.charity;
          break;
        case 'Investments':
          type = TransactionType.investments;
          break;
        default:
          type = TransactionType.expense;
      }
    });
  }

  /// Shows date time picker.
  void _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null && mounted) {
        final newDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        setState(() {
          dateTime = newDateTime;
        });
        _dateTimeController.text = _formatDateTime(newDateTime);
      }
    }
  }

  /// Saves the transaction.
  /// This method creates a transaction using the selected category and form data.
  void _saveTransaction(BuildContext context, AddTransactionMainState state) {
    // Find the selected category model to get the proper ID
    final selectedCategoryModel = availableCategories.firstWhere(
      (cat) => cat.name == selectedCategory,
      orElse: () => availableCategories.first,
    );

    getIt<AddTransactionBloc>().add(
      AddTransactionEvent.addTransaction(
        amount: amount,
        mainCategory:
            selectedCategoryModel.id, // Use category ID as main category
        category: selectedCategory, // Use category name as category
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        dateTime: dateTime,
        type: type,
      ),
    );
  }
}
