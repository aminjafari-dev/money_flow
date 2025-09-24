/// ImagePath class manages all image paths used throughout the application.
///
/// This class centralizes all image asset paths to avoid hardcoding strings
/// and makes it easier to maintain and update image references.
/// It provides category-specific image paths based on transaction categories.
///
/// Usage Example:
/// ```dart
/// Image.asset(ImagePath.charityImage)
/// Image.asset(ImagePath.getCategoryImage('food'))
/// ```
class ImagePath {
  // Private constructor to prevent instantiation
  ImagePath._();

  /// Base path for all images in the assets folder
  static const String _basePath = 'assets/images/';

  /// Charity related image
  static const String charityImage = '${_basePath}charity_image.png';

  /// Expense related image
  static const String expenseImage = '${_basePath}expense_image.png';

  /// Income related image
  static const String incomeImage = '${_basePath}income_image.png';

  /// Investment related image
  static const String investImage = '${_basePath}invest.png';

  /// Returns the appropriate image path based on transaction category.
  /// This method maps transaction categories to their corresponding image assets.
  ///
  /// Parameters:
  /// - [category]: The transaction category to get image for
  ///
  /// Returns:
  /// - [String]: The image path for the category
  ///
  /// Usage Example:
  /// ```dart
  /// String imagePath = ImagePath.getCategoryImage('food');
  /// Image.asset(imagePath)
  /// ```
  static String getCategoryImage(String category) {
    final lowerCategory = category.toLowerCase();

    // Food and groceries categories
    if (lowerCategory.contains('food') ||
        lowerCategory.contains('grocer') ||
        lowerCategory.contains('restaurant') ||
        lowerCategory.contains('dining')) {
      return expenseImage; // Use expense image for food-related expenses
    }

    // Income categories
    if (lowerCategory.contains('salary') ||
        lowerCategory.contains('income') ||
        lowerCategory.contains('wage') ||
        lowerCategory.contains('bonus')) {
      return incomeImage;
    }

    // Charity and donation categories
    if (lowerCategory.contains('charity') ||
        lowerCategory.contains('donation') ||
        lowerCategory.contains('donate')) {
      return charityImage;
    }

    // Investment categories
    if (lowerCategory.contains('investment') ||
        lowerCategory.contains('invest') ||
        lowerCategory.contains('stock') ||
        lowerCategory.contains('saving')) {
      return investImage;
    }

    // Transportation categories
    if (lowerCategory.contains('transport') ||
        lowerCategory.contains('gas') ||
        lowerCategory.contains('fuel') ||
        lowerCategory.contains('car') ||
        lowerCategory.contains('uber') ||
        lowerCategory.contains('taxi')) {
      return expenseImage; // Use expense image for transportation
    }

    // Entertainment categories
    if (lowerCategory.contains('entertainment') ||
        lowerCategory.contains('movie') ||
        lowerCategory.contains('game') ||
        lowerCategory.contains('music')) {
      return expenseImage; // Use expense image for entertainment
    }

    // Shopping categories
    if (lowerCategory.contains('shopping') ||
        lowerCategory.contains('retail') ||
        lowerCategory.contains('store')) {
      return expenseImage; // Use expense image for shopping
    }

    // Health categories
    if (lowerCategory.contains('health') ||
        lowerCategory.contains('medical') ||
        lowerCategory.contains('doctor') ||
        lowerCategory.contains('pharmacy')) {
      return expenseImage; // Use expense image for health expenses
    }

    // Default to expense image for any other categories
    return expenseImage;
  }

  /// Returns the appropriate image path based on transaction type.
  /// This method maps transaction types to their corresponding image assets.
  ///
  /// Parameters:
  /// - [type]: The transaction type ('income', 'expense', 'charity', 'investment')
  ///
  /// Returns:
  /// - [String]: The image path for the type
  ///
  /// Usage Example:
  /// ```dart
  /// String imagePath = ImagePath.getTypeImage('income');
  /// Image.asset(imagePath)
  /// ```
  static String getTypeImage(String type) {
    final lowerType = type.toLowerCase();

    switch (lowerType) {
      case 'income':
        return incomeImage;
      case 'expense':
        return expenseImage;
      case 'charity':
        return charityImage;
      case 'investment':
        return investImage;
      default:
        return expenseImage; // Default to expense image
    }
  }
}
