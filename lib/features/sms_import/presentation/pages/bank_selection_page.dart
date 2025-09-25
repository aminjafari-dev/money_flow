import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_flow/core/constants/no_params.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/core/widgets/g_scaffold.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';
import 'package:money_flow/features/sms_import/domain/usecases/delete_bank_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_all_banks_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/save_bank_usecase.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/bank/bank_card_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/bank/bank_selection_empty_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

import '../../../../shared/models/bank/bank_model.dart';

/// Bank Selection page for managing selected bank numbers for SMS tracking.
/// This page allows users to add, view, and manage banks that they want to
/// track SMS messages from for transaction import.
///
/// Usage Example:
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => const BankSelectionPage(),
///   ),
/// );
/// ```
class BankSelectionPage extends StatefulWidget {
  /// Creates a new instance of BankSelectionPage.
  const BankSelectionPage({super.key});

  @override
  State<BankSelectionPage> createState() => _BankSelectionPageState();
}

class _BankSelectionPageState extends State<BankSelectionPage> {
  List<BankEntity> _selectedBanks = [];
  bool _isLoading = true;
  String? _error;

  // Use cases for bank operations
  late final GetAllBanksUseCase _getAllBanksUseCase;
  late final SaveBankUseCase _saveBankUseCase;
  late final DeleteBankUseCase _deleteBankUseCase;

  @override
  void initState() {
    super.initState();

  // Register Hive adapters
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(BankModelAdapter());
  }
    _getAllBanksUseCase = getIt<GetAllBanksUseCase>();
    _saveBankUseCase = getIt<SaveBankUseCase>();
    _deleteBankUseCase = getIt<DeleteBankUseCase>();

    _loadBanks();
  }

  /// Loads all banks from storage.
  Future<void> _loadBanks() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final result = await _getAllBanksUseCase.call(NoParams());

    result.fold(
      (failure) {
        setState(() {
          _error = failure.message ?? 'Failed to load banks';
          _isLoading = false;
        });
      },
      (banks) {
        setState(() {
          _selectedBanks = banks;
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GScaffold(title: 'Bank Selection', body: _buildBody(l10n));
  }

  /// Builds the main body based on current state.
  Widget _buildBody(AppLocalizations l10n) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadBanks, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (_selectedBanks.isEmpty) {
      return _buildEmptyState(l10n);
    }

    return _buildBanksList(l10n);
  }

  /// Builds the empty state when no banks are selected.
  Widget _buildEmptyState(AppLocalizations l10n) {
    return BankSelectionEmptyWidget(onAddBank: _showAddBankDialog);
  }

  /// Builds the list of selected banks.
  Widget _buildBanksList(AppLocalizations l10n) {
    return Column(
      children: [
        // Add bank button at the top
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GButton(
            text: 'Add Bank',
            icon: Icons.add,
            onPressed: _showAddBankDialog,
            isFullWidth: true,
          ),
        ),

        // Banks list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _selectedBanks.length,
            itemBuilder: (context, index) {
              final bank = _selectedBanks[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: BankCardWidget(
                  bank: bank,
                  onTap: () => _navigateToSmsImport(bank),
                  onDelete: () => _deleteBank(bank),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Navigates to SMS conversations to select a bank.
  void _showAddBankDialog() {
    Navigator.pushNamed(context, PageName.smsConversationsForBank).then((
      result,
    ) async {
      if (result != null && result is BankEntity) {
        await _saveBank(result);
      }
    });
  }

  /// Saves a bank to storage.
  Future<void> _saveBank(BankEntity bank) async {
    final result = await _saveBankUseCase.call(SaveBankParams(bank: bank));

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save bank: ${failure.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (_) {
        setState(() {
          _selectedBanks.add(bank);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bank added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  /// Navigates to SMS import page for the selected bank.
  void _navigateToSmsImport(BankEntity bank) {
    Navigator.pushNamed(context, PageName.smsImport, arguments: bank);
  }

  /// Deletes a bank from the selection.
  Future<void> _deleteBank(BankEntity bank) async {
    final result = await _deleteBankUseCase.call(
      DeleteBankParams(bankId: bank.id),
    );

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete bank: ${failure.message}'),
            backgroundColor: Colors.red,
          ),
        );
      },
      (_) {
        setState(() {
          _selectedBanks.removeWhere((b) => b.id == bank.id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bank deleted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
