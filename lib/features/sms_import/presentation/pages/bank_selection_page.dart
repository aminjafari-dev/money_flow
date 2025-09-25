import 'package:flutter/material.dart';
import 'package:money_flow/core/router/page_name.dart';
import 'package:money_flow/core/widgets/g_scaffold.dart';
import 'package:money_flow/core/widgets/g_button.dart';
import 'package:money_flow/features/sms_import/domain/entities/bank_entity.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/bank/bank_card_widget.dart';
import 'package:money_flow/features/sms_import/presentation/widgets/bank/bank_selection_empty_widget.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

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
  // TODO: This should be managed by a BLoC or state management solution
  // For now, using a simple list for demonstration
  List<BankEntity> _selectedBanks = [];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GScaffold(
      title: 'Bank Selection',
      body: _selectedBanks.isEmpty
          ? _buildEmptyState(l10n)
          : _buildBanksList(l10n),
    );
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
    ) {
      if (result != null && result is BankEntity) {
        setState(() {
          _selectedBanks.add(result);
        });
      }
    });
  }

  /// Navigates to SMS import page for the selected bank.
  void _navigateToSmsImport(BankEntity bank) {
    Navigator.pushNamed(context, PageName.smsImport, arguments: bank);
  }

  /// Deletes a bank from the selection.
  void _deleteBank(BankEntity bank) {
    setState(() {
      _selectedBanks.removeWhere((b) => b.id == bank.id);
    });
  }
}
