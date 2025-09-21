import 'package:flutter/material.dart';
import 'package:money_flow/core/theme/app_colors.dart';
import 'package:money_flow/core/theme/app_fonts.dart';
import 'package:money_flow/core/widgets/g_text.dart';
import 'package:money_flow/core/widgets/g_gap.dart';

/// Widget for selecting transaction categories and subcategories.
/// This widget provides a user-friendly interface for selecting categories
/// with visual chips and proper state management.
///
/// Usage Example:
/// ```dart
/// CategorySelectorWidget(
///   categories: ['Food', 'Transportation', 'Entertainment'],
///   selectedCategory: 'Food',
///   onCategorySelected: (category) {
///     context.read<AddTransactionBloc>().add(
///       AddTransactionEvent.updateCategory(category: category),
///     );
///   },
/// )
/// ```
class CategorySelectorWidget extends StatelessWidget {
  /// List of available categories
  final List<String> categories;

  /// Currently selected category
  final String selectedCategory;

  /// Callback when category is selected
  final ValueChanged<String> onCategorySelected;

  /// Whether the selector is enabled
  final bool enabled;

  /// Loading state for categories
  final bool isLoading;

  /// Error message if category loading fails
  final String? errorMessage;

  const CategorySelectorWidget({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.enabled = true,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(Icons.category_outlined, color: AppColors.primary, size: 20.0),
            GGap.small(),
            GText(
              'CATEGORY',
              style: AppFonts.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        GGap.medium(),

        // Category selection area
        if (isLoading)
          _buildLoadingState()
        else if (errorMessage != null)
          _buildErrorState()
        else
          _buildCategoryChips(),
      ],
    );
  }

  /// Builds the loading state for categories.
  /// This method displays a loading indicator while categories are being fetched.
  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16.0,
            height: 16.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          GGap.small(),
          GText(
            'Loading categories...',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the error state for categories.
  /// This method displays an error message when category loading fails.
  Widget _buildErrorState() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.onErrorContainer,
            size: 20.0,
          ),
          GGap.small(),
          Expanded(
            child: GText(
              errorMessage!,
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the category chips for selection.
  /// This method displays all available categories as selectable chips.
  Widget _buildCategoryChips() {
    if (categories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: GText(
          'No categories available',
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        final isSelected = category == selectedCategory;
        return _buildCategoryChip(category, isSelected);
      }).toList(),
    );
  }

  /// Builds an individual category chip.
  /// This method creates a selectable chip for a specific category.
  ///
  /// Parameters:
  /// - [category]: The category name
  /// - [isSelected]: Whether this category is currently selected
  ///
  /// Returns:
  /// - [Widget]: The category chip widget
  Widget _buildCategoryChip(String category, bool isSelected) {
    return GestureDetector(
      onTap: enabled ? () => onCategorySelected(category) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 4.0,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category icon
            Icon(
              _getCategoryIcon(category),
              size: 18.0,
              color: isSelected
                  ? AppColors.onPrimary
                  : AppColors.onSurfaceVariant,
            ),
            GGap.small(),

            // Category name
            GText(
              category,
              style: AppFonts.labelMedium.copyWith(
                color: isSelected
                    ? AppColors.onPrimary
                    : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gets the appropriate icon for a category.
  /// This method returns an icon that represents the category visually.
  ///
  /// Parameters:
  /// - [category]: The category name
  ///
  /// Returns:
  /// - [IconData]: The icon for the category
  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant_outlined;
      case 'transportation':
        return Icons.directions_car_outlined;
      case 'entertainment':
        return Icons.movie_outlined;
      case 'utilities':
        return Icons.electrical_services_outlined;
      case 'other':
        return Icons.category_outlined;
      default:
        return Icons.label_outline;
    }
  }
}

/// Widget for selecting transaction subcategories.
/// This widget provides a user-friendly interface for selecting subcategories
/// based on the selected main category.
///
/// Usage Example:
/// ```dart
/// SubcategorySelectorWidget(
///   subcategories: ['Groceries', 'Restaurant', 'Fast Food'],
///   selectedSubcategory: 'Groceries',
///   onSubcategorySelected: (subcategory) {
///     context.read<AddTransactionBloc>().add(
///       AddTransactionEvent.updateSubcategory(subcategory: subcategory),
///     );
///   },
/// )
/// ```
class SubcategorySelectorWidget extends StatelessWidget {
  /// List of available subcategories
  final List<String> subcategories;

  /// Currently selected subcategory
  final String selectedSubcategory;

  /// Callback when subcategory is selected
  final ValueChanged<String> onSubcategorySelected;

  /// Whether the selector is enabled
  final bool enabled;

  /// Loading state for subcategories
  final bool isLoading;

  /// Error message if subcategory loading fails
  final String? errorMessage;

  const SubcategorySelectorWidget({
    super.key,
    required this.subcategories,
    required this.selectedSubcategory,
    required this.onSubcategorySelected,
    this.enabled = true,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Icon(
              Icons.subdirectory_arrow_right,
              color: AppColors.primary,
              size: 20.0,
            ),
            GGap.small(),
            GText(
              'SUBCATEGORY',
              style: AppFonts.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        GGap.medium(),

        // Subcategory selection area
        if (isLoading)
          _buildLoadingState()
        else if (errorMessage != null)
          _buildErrorState()
        else
          _buildSubcategoryChips(),
      ],
    );
  }

  /// Builds the loading state for subcategories.
  /// This method displays a loading indicator while subcategories are being fetched.
  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16.0,
            height: 16.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          GGap.small(),
          GText(
            'Loading subcategories...',
            style: AppFonts.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the error state for subcategories.
  /// This method displays an error message when subcategory loading fails.
  Widget _buildErrorState() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.onErrorContainer,
            size: 20.0,
          ),
          GGap.small(),
          Expanded(
            child: GText(
              errorMessage!,
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the subcategory chips for selection.
  /// This method displays all available subcategories as selectable chips.
  Widget _buildSubcategoryChips() {
    if (subcategories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: GText(
          'No subcategories available',
          style: AppFonts.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: subcategories.map((subcategory) {
        final isSelected = subcategory == selectedSubcategory;
        return _buildSubcategoryChip(subcategory, isSelected);
      }).toList(),
    );
  }

  /// Builds an individual subcategory chip.
  /// This method creates a selectable chip for a specific subcategory.
  ///
  /// Parameters:
  /// - [subcategory]: The subcategory name
  /// - [isSelected]: Whether this subcategory is currently selected
  ///
  /// Returns:
  /// - [Widget]: The subcategory chip widget
  Widget _buildSubcategoryChip(String subcategory, bool isSelected) {
    return GestureDetector(
      onTap: enabled ? () => onSubcategorySelected(subcategory) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.outline,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: GText(
          subcategory,
          style: AppFonts.labelSmall.copyWith(
            color: isSelected
                ? AppColors.onSecondary
                : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
