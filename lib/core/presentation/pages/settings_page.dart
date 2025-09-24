import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Settings page placeholder.
/// This page will contain app settings and preferences in the future.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GScaffold(title: l10n.settings, body: const SizedBox());
  }
}
