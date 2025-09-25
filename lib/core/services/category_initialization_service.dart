import 'package:money_flow/core/services/category_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/shared/models/category/category_models.dart';

/// Service for initializing categories during app startup.
/// This service ensures that the CategoryService is properly initialized
/// and categories are available throughout the application.
///
/// Usage Example:
/// ```dart
/// final initService = CategoryInitializationService();
/// await initService.initialize();
/// ```
class CategoryInitializationService {
  final CategoryService _categoryService;

  CategoryInitializationService(this._categoryService);

  /// Initializes the category system during app startup.
  /// This method should be called once during application initialization.
  ///
  /// Usage Example:
  /// ```dart
  /// final initService = CategoryInitializationService(categoryService);
  /// await initService.initialize();
  /// ```
  Future<void> initialize() async {
    try {

      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(CategoryModelAdapter());
      }

      // Initialize the CategoryService
      await _categoryService.initialize();

      print('Category system initialized successfully');
    } catch (e) {
      print('Failed to initialize category system: $e');
      rethrow;
    }
  }

  /// Reinitializes categories with default values.
  /// This method can be used to reset categories to default state.
  ///
  /// Usage Example:
  /// ```dart
  /// await initService.reinitialize();
  /// ```
  Future<void> reinitialize() async {
    try {
      // Clear and reinitialize categories
      await _categoryService.clearAllCategories();

      print('Category system reinitialized successfully');
    } catch (e) {
      print('Failed to reinitialize category system: $e');
      rethrow;
    }
  }

  /// Checks if the category system is properly initialized.
  /// This method verifies that all main categories are available.
  ///
  /// Returns:
  /// - [bool]: True if properly initialized, false otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// final isInitialized = await initService.isInitialized();
  /// if (!isInitialized) {
  ///   await initService.initialize();
  /// }
  /// ```
  Future<bool> isInitialized() async {
    try {
      final mainCategories = await _categoryService.getMainCategories();

      // Check if we have the expected 4 main categories
      return mainCategories.length == 4 &&
          mainCategories.any((cat) => cat.id == 'income') &&
          mainCategories.any((cat) => cat.id == 'expenses') &&
          mainCategories.any((cat) => cat.id == 'charity') &&
          mainCategories.any((cat) => cat.id == 'investments');
    } catch (e) {
      return false;
    }
  }
}
