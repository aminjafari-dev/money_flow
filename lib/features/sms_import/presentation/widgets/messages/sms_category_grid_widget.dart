import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_gap.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/core/constants/image_path.dart';
import 'package:money_flow/features/sms_import/domain/entities/sms_entity.dart';
import 'package:money_flow/features/sms_import/domain/usecases/get_sms_category_status_usecase.dart';
import 'package:money_flow/features/sms_import/domain/usecases/add_sms_to_category_usecase.dart';
import 'package:money_flow/core/di/locator.dart';
import 'package:money_flow/l10n/generated/app_localizations.dart';

/// Grid widget for displaying category selection buttons for SMS messages.
/// This widget shows 4 main categories (Income, Expenses, Charity, Investments)
/// in a 2x2 grid layout with visual feedback for added categories.
///
/// Usage Example:
/// ```dart
/// SmsCategoryGridWidget(
///   message: message,
///   onCategoryAdded: (category) => print('Added to $category'),
/// )
/// ```
class SmsCategoryGridWidget extends StatefulWidget {
  /// The SMS entity to display categories for.
  final SmsEntity message;

  /// Callback when a category is successfully added
  final Function(String category)? onCategoryAdded;

  /// Creates a new instance of SmsCategoryGridWidget.
  ///
  /// Parameters:
  /// - [message]: The SMS entity to display categories for
  /// - [onCategoryAdded]: Callback when a category is successfully added
  const SmsCategoryGridWidget({
    super.key,
    required this.message,
    this.onCategoryAdded,
  });

  @override
  State<SmsCategoryGridWidget> createState() => _SmsCategoryGridWidgetState();
}

class _SmsCategoryGridWidgetState extends State<SmsCategoryGridWidget> {
  SmsCategoryStatus? _categoryStatus;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategoryStatus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _buildCategoryGrid(l10n);
  }

  /// Builds the 2x2 category grid.
  /// This method creates a grid layout with 4 main categories.
  Widget _buildCategoryGrid(AppLocalizations l10n) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.2,
      shrinkWrap: true,
      children: [
        _buildCategoryButton(
          'Income',
          'income',
          AppColors.success,
          Icons.trending_up,
          l10n,
        ),
        _buildCategoryButton(
          'Expenses',
          'expenses',
          AppColors.error,
          Icons.trending_down,
          l10n,
        ),
        _buildCategoryButton(
          'Charity',
          'charity',
          AppColors.warning,
          Icons.volunteer_activism,
          l10n,
        ),
        _buildCategoryButton(
          'Investments',
          'investment',
          AppColors.primary,
          Icons.account_balance,
          l10n,
        ),
      ],
    );
  }

  /// Builds a single category button for the grid.
  /// This method creates a square button with background image and text for a specific category.
  /// The image is used as background with the category name displayed in the center.
  Widget _buildCategoryButton(
    String category,
    String mainCategory,
    Color color,
    IconData icon,
    AppLocalizations l10n,
  ) {
    final isAdded = _categoryStatus?.isAddedToCategory(category) ?? false;
    final imagePath = ImagePath.getTypeImage(mainCategory);

    return GestureDetector(
      onTap: isAdded ? null : () => _addToCategory(category, mainCategory),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isAdded ? color : color.withValues(alpha: 0.3),
            width: 2,
          ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(
            //   isAdded
                //       ? Colors.white.withValues(alpha: 0.8)
            //       : Colors.white.withValues(alpha: 0.6),
            //   BlendMode.overlay,
            // ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isAdded
                ? color.withValues(alpha: 0.6)
                : Colors.black.withValues(alpha: 0.2),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Check icon for added state
                if (isAdded)
                  Icon(Icons.check_circle, size: 20, color: Colors.white),
                if (isAdded) GGap.extraSmall(),
                // Category name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GText(
                    category,
                    style: AppFonts.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Loads the category status for this SMS message.
  /// This method checks which categories the SMS has been added to.
  Future<void> _loadCategoryStatus() async {
    try {
      final getStatusUseCase = getIt<GetSmsCategoryStatusUseCase>();
      final result = await getStatusUseCase.call(
        GetSmsCategoryStatusParams(smsId: widget.message.id),
      );

      result.fold(
        (failure) {
          // Handle error silently for now
          setState(() {
            _categoryStatus = SmsCategoryStatus(
              smsId: widget.message.id,
              isAddedToIncome: false,
              isAddedToExpenses: false,
              isAddedToCharity: false,
              isAddedToInvestments: false,
              addedCategories: [],
            );
          });
        },
        (status) {
          setState(() {
            _categoryStatus = status;
          });
        },
      );
    } catch (e) {
      // Handle error silently for now
      setState(() {
        _categoryStatus = SmsCategoryStatus(
          smsId: widget.message.id,
          isAddedToIncome: false,
          isAddedToExpenses: false,
          isAddedToCharity: false,
          isAddedToInvestments: false,
          addedCategories: [],
        );
      });
    }
  }

  /// Adds the SMS message to a specific category.
  /// This method creates a transaction from the SMS and tracks the assignment.
  Future<void> _addToCategory(String category, String mainCategory) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Extract amount from SMS body (simplified implementation)
      final amount = _extractAmountFromSms(widget.message.body);

      if (amount == null) {
        _showErrorSnackBar('Could not extract amount from SMS');
        return;
      }

      // Use the actual use case to add SMS to category
      final addToCategoryUseCase = getIt<AddSmsToCategoryUseCase>();
      final result = await addToCategoryUseCase.call(
        AddSmsToCategoryParams(
          sms: widget.message,
          category: category,
          mainCategory: mainCategory,
          amount: amount,
        ),
      );

      result.fold(
        (failure) {
          _showErrorSnackBar('Failed to add to $category: ${failure.message}');
        },
        (transaction) {
          // Reload category status to reflect the changes
          _loadCategoryStatus();
          _showSuccessSnackBar('Added to $category');
          widget.onCategoryAdded?.call(category);
        },
      );
    } catch (e) {
      _showErrorSnackBar('Failed to add to $category');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Extracts amount from SMS body.
  /// This method attempts to find monetary amounts in the SMS text.
  double? _extractAmountFromSms(String smsBody) {
    // Simple regex to find amounts like $25.50, 25.50, etc.
    final regex = RegExp(r'[\$]?(\d+\.?\d*)');
    final matches = regex.allMatches(smsBody);

    for (final match in matches) {
      final amountStr = match.group(1);
      if (amountStr != null) {
        final amount = double.tryParse(amountStr);
        if (amount != null && amount > 0) {
          return amount;
        }
      }
    }

    return null;
  }

  /// Shows a success snackbar.
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.success),
    );
  }

  /// Shows an error snackbar.
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }
}
