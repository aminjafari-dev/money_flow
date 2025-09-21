import 'package:flutter/material.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/features/transactions/domain/entities/transaction_entity.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_bloc.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_event.dart';
import 'package:money_flow/features/transactions/presentation/bloc/add_transaction_state.dart';
import 'package:money_flow/features/transactions/presentation/widgets/amount_display_widget.dart';
import 'package:money_flow/features/transactions/presentation/widgets/amount_input_dialog_widget.dart';
import 'package:money_flow/features/transactions/presentation/widgets/category_selector_widget.dart';
import 'package:money_flow/features/transactions/presentation/widgets/transaction_action_buttons_widget.dart';
import 'package:money_flow/features/transactions/presentation/widgets/transaction_form_field_widget.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize the form when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<AddTransactionBloc>().add(const AddTransactionEvent.initialize());
    });

    // Set default date time
    _dateTimeController.text = _formatDateTime(DateTime.now());
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddTransactionBloc>(),
      child: BlocConsumer<AddTransactionBloc, AddTransactionMainState>(
        listener: (context, state) {
          // Handle transaction addition success
          state.addTransaction.when(
            initial: () {},
            loading: () {},
            completed: (transaction) {
              _showSuccessSnackBar('Transaction added successfully!');
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
            appBar: _buildSimpleAppBar(context),
            body: _buildSimpleBody(context, state),
          );
        },
      ),
    );
  }

  /// Builds a simple app bar matching the design image.
  /// This method creates a minimal app bar with just close button and title.
  PreferredSizeWidget _buildSimpleAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const GText(
        'Add Transaction',
        style: TextStyle(
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
  Widget _buildSimpleBody(BuildContext context, AddTransactionMainState state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large amount display at top
            _buildAmountDisplay(state),

            const SizedBox(height: 40),

            // Category section
            _buildCategorySection(state),

            const SizedBox(height: 30),

            // Subcategory section
            _buildSubcategorySection(state),

            const SizedBox(height: 30),

            // Description field
            _buildDescriptionField(),

            const SizedBox(height: 20),

            // Date & Time field
            _buildDateTimeField(),

            const Spacer(),

            // Action buttons at bottom
            _buildActionButtons(context, state),
          ],
        ),
      ),
    );
  }

  /// Builds the large amount display at the top of the form.
  /// This shows the current transaction amount in a large, prominent format.
  Widget _buildAmountDisplay(AddTransactionMainState state) {
    return AmountDisplayWidget(
      amount: state.amount,
      onAmountTapped: () => _showAmountInputDialog(context, state),
    );
  }

  /// Builds the category selection section with horizontal chips.
  /// This shows available categories as selectable chips.
  Widget _buildCategorySection(AddTransactionMainState state) {
    return state.loadCategories.when(
      initial: () => const SizedBox(),
      loading: () => CategorySelectorWidget(
        categories: const [],
        selectedCategory: '',
        onCategorySelected: (_) {},
        isLoading: true,
      ),
      completed: (categories) => CategorySelectorWidget(
        categories: categories,
        selectedCategory: state.selectedCategory,
        onCategorySelected: (category) => _selectCategory(context, category),
      ),
      error: (message) => CategorySelectorWidget(
        categories: const [],
        selectedCategory: '',
        onCategorySelected: (_) {},
        errorMessage: message,
      ),
    );
  }

  /// Builds the subcategory selection section with horizontal chips.
  /// This shows available subcategories for the selected category.
  Widget _buildSubcategorySection(AddTransactionMainState state) {
    if (state.selectedCategory.isEmpty) {
      return const SizedBox();
    }

    return state.loadSubcategories.when(
      initial: () => const SizedBox(),
      loading: () => SubcategorySelectorWidget(
        subcategories: const [],
        selectedSubcategory: '',
        onSubcategorySelected: (_) {},
        isLoading: true,
      ),
      completed: (subcategories) => SubcategorySelectorWidget(
        subcategories: subcategories,
        selectedSubcategory: state.selectedSubcategory,
        onSubcategorySelected: (subcategory) =>
            _selectSubcategory(context, subcategory),
      ),
      error: (message) => SubcategorySelectorWidget(
        subcategories: const [],
        selectedSubcategory: '',
        onSubcategorySelected: (_) {},
        errorMessage: message,
      ),
    );
  }

  /// Builds the description input field.
  /// This creates a simple text field for transaction description.
  Widget _buildDescriptionField() {
    return TransactionFormFieldWidget(
      controller: _descriptionController,
      labelText: 'Description',
      hintText: 'Enter description',
      onChanged: (value) {
        context.read<AddTransactionBloc>().add(
          AddTransactionEvent.updateDescription(
            description: value.isEmpty ? null : value,
          ),
        );
      },
    );
  }

  /// Builds the date and time input field.
  /// This creates a simple text field for transaction date and time.
  Widget _buildDateTimeField() {
    return TransactionFormFieldWidget(
      controller: _dateTimeController,
      labelText: 'Date & Time',
      hintText: 'Select date and time',
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
  ) {
    final isLoading = state.addTransaction.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final canSave =
        state.selectedCategory.isNotEmpty &&
        state.selectedSubcategory.isNotEmpty &&
        state.amount != 0;

    return TransactionActionButtonsWidget(
      onCancel: () => Navigator.of(context).pop(),
      onSave: () => _saveTransaction(context, state),
      isLoading: isLoading,
      canSave: canSave,
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

  /// Shows amount input dialog.
  void _showAmountInputDialog(
    BuildContext context,
    AddTransactionMainState state,
  ) {
    AmountInputDialogWidget.show(
      context: context,
      initialAmount: state.amount,
      onAmountConfirmed: (amount) {
        getIt<AddTransactionBloc>().add(
          AddTransactionEvent.updateAmount(amount: amount),
        );
      },
    );
  }

  /// Selects a category.
  void _selectCategory(BuildContext context, String category) {
    context.read<AddTransactionBloc>().add(
      AddTransactionEvent.updateCategory(category: category),
    );
  }

  /// Selects a subcategory.
  void _selectSubcategory(BuildContext context, String subcategory) {
    context.read<AddTransactionBloc>().add(
      AddTransactionEvent.updateSubcategory(subcategory: subcategory),
    );
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
        final dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );

        _dateTimeController.text = _formatDateTime(dateTime);
        context.read<AddTransactionBloc>().add(
          AddTransactionEvent.updateDateTime(dateTime: dateTime),
        );
      }
    }
  }

  /// Saves the transaction.
  void _saveTransaction(BuildContext context, AddTransactionMainState state) {
    context.read<AddTransactionBloc>().add(
      AddTransactionEvent.addTransaction(
        amount: state.amount,
        category: state.selectedCategory,
        subcategory: state.selectedSubcategory,
        description: state.description,
        dateTime: state.dateTime ?? DateTime.now(),
        type: TransactionType.expense,
      ),
    );
  }
}
