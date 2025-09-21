import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/widgets.dart';

/// Example widget demonstrating the usage of GGap class.
/// This file shows various ways to use the GGap widget for consistent spacing.
///
/// Note: This is just an example file and should be removed in production.
class GGapExample extends StatelessWidget {
  const GGapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return GScaffold(
      title: 'GGap Usage Examples',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            GText(
              'GGap Spacing Examples',
              style: GTextStyle.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            GGap.large(),

            // Basic spacing examples
            GText(
              'Basic Spacing:',
              style: GTextStyle.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            GGap.medium(),

            // Row with horizontal spacing
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                  child: const Icon(Icons.home, color: Colors.white),
                ),
                GGap.horizontal(12.0), // Custom horizontal spacing
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: const Icon(Icons.favorite, color: Colors.white),
                ),
                GGap.horizontal(8.0), // Small horizontal spacing
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  child: const Icon(Icons.star, color: Colors.white),
                ),
              ],
            ),
            GGap.medium(),

            // Column with vertical spacing
            GText(
              'Vertical Spacing:',
              style: GTextStyle.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            GGap.medium(),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  GText('Item 1', style: GTextStyle.bodyLarge),
                  GGap.vertical(8.0), // Small vertical spacing
                  GText('Item 2', style: GTextStyle.bodyLarge),
                  GGap.vertical(16.0), // Medium vertical spacing
                  GText('Item 3', style: GTextStyle.bodyLarge),
                  GGap.vertical(24.0), // Large vertical spacing
                  GText('Item 4', style: GTextStyle.bodyLarge),
                ],
              ),
            ),
            GGap.large(),

            // Predefined spacing sizes
            GText(
              'Predefined Spacing Sizes:',
              style: GTextStyle.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            GGap.medium(),

            _buildSpacingExample('Extra Small (4px)', GGap.extraSmall()),
            _buildSpacingExample('Small (8px)', GGap.small()),
            _buildSpacingExample('Medium (16px)', GGap.medium()),
            _buildSpacingExample('Large (24px)', GGap.large()),
            _buildSpacingExample('Extra Large (32px)', GGap.extraLarge()),
            _buildSpacingExample(
              'Extra Extra Large (48px)',
              GGap.extraExtraLarge(),
            ),
            _buildSpacingExample('Zero (0px)', GGap.zero()),

            GGap.large(),

            // Custom spacing
            GText(
              'Custom Spacing:',
              style: GTextStyle.titleMedium,
              fontWeight: FontWeight.w600,
            ),
            GGap.medium(),

            _buildSpacingExample('Custom 20px', GGap.custom(20.0)),
            _buildSpacingExample('Custom 36px', GGap.custom(36.0)),

            GGap.extraLarge(),

            // Usage tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GText(
                    'Usage Tips:',
                    style: GTextStyle.titleMedium,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800],
                  ),
                  GGap.small(),
                  GText(
                    '• Use GGap.small() for minimal spacing between related elements',
                    style: GTextStyle.bodyMedium,
                  ),
                  GText(
                    '• Use GGap.medium() as default spacing for most UI components',
                    style: GTextStyle.bodyMedium,
                  ),
                  GText(
                    '• Use GGap.large() for spacing between major sections',
                    style: GTextStyle.bodyMedium,
                  ),
                  GText(
                    '• Use GGap.custom() when you need specific spacing values',
                    style: GTextStyle.bodyMedium,
                  ),
                  GText(
                    '• Use GGap.horizontal() and GGap.vertical() for directional spacing',
                    style: GTextStyle.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method to build spacing examples with visual indicators
  Widget _buildSpacingExample(String label, Widget gap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GText(label, style: GTextStyle.bodyMedium, fontWeight: FontWeight.w500),
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              color: Colors.orange,
              child: const Icon(Icons.circle, color: Colors.white, size: 16),
            ),
            gap, // The gap widget being demonstrated
            Container(
              width: 30,
              height: 30,
              color: Colors.purple,
              child: const Icon(Icons.circle, color: Colors.white, size: 16),
            ),
          ],
        ),
        GGap.small(),
      ],
    );
  }
}
