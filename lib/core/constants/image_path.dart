/// ImagePath class manages all image paths used throughout the application.
///
/// This class centralizes all image asset paths to avoid hardcoding strings
/// and makes it easier to maintain and update image references.
///
/// Usage Example:
/// ```dart
/// Image.asset(ImagePath.charityImage)
/// Image.asset(ImagePath.expenseImage)
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
}
