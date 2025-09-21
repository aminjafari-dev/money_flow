/// Core widgets for the Money Flow application.
/// This file exports all global widgets for easy importing.
///
/// Usage Example:
/// ```dart
/// import 'package:money_flow/core/widgets/widgets.dart';
///
/// // Now you can use GScaffold, GText, and GGap
/// GScaffold(
///   title: 'Dashboard',
///   body: Column(
///     children: [
///       GText('Welcome to Money Flow'),
///       GGap.medium(), // Standard spacing
///       ElevatedButton(onPressed: () {}, child: Text('Action')),
///     ],
///   ),
/// )
/// ```

export 'g_scaffold.dart';
export 'g_gap.dart';
export 'g_text.dart';
