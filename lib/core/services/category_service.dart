import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/shared/models/category/category_models.dart';

/// Service for managing categories.
/// This service handles all category operations including initialization,
/// CRUD operations, and local storage management.
///
/// Currently supports 4 main categories: Income, Expenses, Charity, Investments
/// without any subcategories for simplified transaction categorization.
///
/// Usage Example:
/// ```dart
/// final categoryService = CategoryService();
/// await categoryService.initialize();
///
/// // Get main categories
/// final mainCategories = await categoryService.getMainCategories();
///
/// // Get a specific category
/// final category = await categoryService.getCategory('income');
///
/// // Add new category
/// await categoryService.addCategory(newCategory);
/// ```
class CategoryService {
  /// Hive box name for storing category data
  static const String _categoryBoxName = 'categories';

  /// Hive box instance for category data
  Box<CategoryModel>? _categoryBox;

  /// Initializes Hive box for category data.
  /// This method must be called before using any other methods.
  ///
  /// Usage Example:
  /// ```dart
  /// final categoryService = CategoryService();
  /// await categoryService.initialize();
  /// ```
  Future<void> initialize() async {
    try {
      // Register adapter for type-safe storage
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(CategoryModelAdapter());
      }

      // Open category data box
      _categoryBox = await Hive.openBox<CategoryModel>(_categoryBoxName);

      // Initialize default categories if box is empty
      if (_categoryBox!.isEmpty) {
        await _initializeDefaultCategories();
      }
    } catch (e) {
      // If initialization fails, throw cache exception
      throw CacheException('Failed to initialize category service: $e');
    }
  }

  /// Initializes default categories on first app startup.
  /// This method sets up the 4 main categories without any subcategories.
  Future<void> _initializeDefaultCategories() async {
    try {
      // Define the 4 main categories without subcategories
      final defaultCategories = [
        // Income - Main category for all income types
        CategoryModel(
          id: 'income',
          name: 'Income',
          type: 'main',
          icon: 'income_icon',
          subcategories: [], // No subcategories
        ),

        // Expenses - Main category for all expense types
        CategoryModel(
          id: 'expenses',
          name: 'Expenses',
          type: 'main',
          icon: 'expense_icon',
          subcategories: [], // No subcategories
        ),

        // Charity - Main category for charitable donations
        CategoryModel(
          id: 'charity',
          name: 'Charity',
          type: 'main',
          icon: 'charity_icon',
          subcategories: [], // No subcategories
        ),

        // Investments - Main category for all investment types
        CategoryModel(
          id: 'investments',
          name: 'Investments',
          type: 'main',
          icon: 'investment_icon',
          subcategories: [], // No subcategories
        ),
      ];

      // Store all categories in Hive
      for (final category in defaultCategories) {
        await _categoryBox!.put(category.id, category);
      }
    } catch (e) {
      throw CacheException('Failed to initialize default categories: $e');
    }
  }

  /// Gets all main categories.
  /// Returns the 4 main categories: Income, Expenses, Charity, Investments.
  ///
  /// Returns:
  /// - [List<CategoryModel>]: List of main category models
  ///
  /// Usage Example:
  /// ```dart
  /// final mainCategories = await categoryService.getMainCategories();
  /// for (final category in mainCategories) {
  ///   print('Category: ${category.name}');
  /// }
  /// ```
  Future<List<CategoryModel>> getMainCategories() async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Get all main categories
      final allCategories = _categoryBox!.values.toList();
      return allCategories
          .where((category) => category.type == 'main')
          .toList();
    } catch (e) {
      throw CacheException('Failed to get main categories: $e');
    }
  }

  /// Gets subcategories for a specific main category.
  /// Note: Currently returns empty list as subcategories are not used.
  ///
  /// Parameters:
  /// - [mainCategoryId]: ID of the main category
  ///
  /// Returns:
  /// - [List<String>]: Empty list (no subcategories)
  ///
  /// Usage Example:
  /// ```dart
  /// final subcategories = await categoryService.getSubcategories('income');
  /// // Returns: []
  /// ```
  Future<List<String>> getSubcategories(String mainCategoryId) async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Get the main category
      final category = _categoryBox!.get(mainCategoryId);
      if (category == null || category.type != 'main') {
        return [];
      }

      // Return empty list as we don't use subcategories
      return [];
    } catch (e) {
      throw CacheException('Failed to get subcategories: $e');
    }
  }

  /// Gets a specific category by ID.
  ///
  /// Parameters:
  /// - [categoryId]: ID of the category to retrieve
  ///
  /// Returns:
  /// - [CategoryModel?]: Category model or null if not found
  ///
  /// Usage Example:
  /// ```dart
  /// final category = await categoryService.getCategory('income');
  /// ```
  Future<CategoryModel?> getCategory(String categoryId) async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      return _categoryBox!.get(categoryId);
    } catch (e) {
      throw CacheException('Failed to get category: $e');
    }
  }

  /// Adds a new category or updates an existing one.
  ///
  /// Parameters:
  /// - [category]: Category model to add or update
  ///
  /// Usage Example:
  /// ```dart
  /// final newCategory = CategoryModel(
  ///   id: 'custom_category',
  ///   name: 'Custom Category',
  ///   type: 'main',
  ///   subcategories: ['Sub1', 'Sub2'],
  /// );
  /// await categoryService.addCategory(newCategory);
  /// ```
  Future<void> addCategory(CategoryModel category) async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Store category
      await _categoryBox!.put(category.id, category);
    } catch (e) {
      throw CacheException('Failed to add category: $e');
    }
  }

  /// Adds a subcategory to an existing main category.
  /// Note: This method is deprecated as subcategories are not used.
  ///
  /// Parameters:
  /// - [mainCategoryId]: ID of the main category
  /// - [subcategoryName]: Name of the subcategory to add
  ///
  /// Usage Example:
  /// ```dart
  /// // This method does nothing as subcategories are not supported
  /// await categoryService.addSubcategory('income', 'Consulting');
  /// ```
  @Deprecated('Subcategories are not supported in the current implementation')
  Future<void> addSubcategory(
    String mainCategoryId,
    String subcategoryName,
  ) async {
    // Do nothing - subcategories are not supported
    return;
  }

  /// Determines the main category for a given subcategory.
  /// Note: Always returns null as subcategories are not used.
  ///
  /// Parameters:
  /// - [subcategoryName]: Name of the subcategory
  ///
  /// Returns:
  /// - [String?]: Always null (no subcategories exist)
  ///
  /// Usage Example:
  /// ```dart
  /// final mainCategory = await categoryService.getMainCategoryForSubcategory('Salary');
  /// // Returns: null
  /// ```
  @Deprecated('Subcategories are not supported in the current implementation')
  Future<String?> getMainCategoryForSubcategory(String subcategoryName) async {
    // Always return null as subcategories are not supported
    return null;
  }

  /// Gets all subcategories across all main categories.
  /// Note: Always returns empty list as subcategories are not used.
  ///
  /// Returns:
  /// - [List<String>]: Empty list (no subcategories exist)
  ///
  /// Usage Example:
  /// ```dart
  /// final allSubcategories = await categoryService.getAllSubcategories();
  /// // Returns: []
  /// ```
  @Deprecated('Subcategories are not supported in the current implementation')
  Future<List<String>> getAllSubcategories() async {
    // Always return empty list as subcategories are not supported
    return [];
  }

  /// Clears all category data.
  /// This method is useful for data cleanup or reset scenarios.
  ///
  /// Usage Example:
  /// ```dart
  /// await categoryService.clearAllCategories();
  /// ```
  Future<void> clearAllCategories() async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Clear all categories
      await _categoryBox!.clear();

      // Reinitialize default categories
      await _initializeDefaultCategories();
    } catch (e) {
      throw CacheException('Failed to clear all categories: $e');
    }
  }

  /// Closes the category service and cleans up resources.
  /// This method should be called when the service is no longer needed.
  ///
  /// Usage Example:
  /// ```dart
  /// await categoryService.dispose();
  /// ```
  Future<void> dispose() async {
    try {
      await _categoryBox?.close();
    } catch (e) {
      // Log error but don't throw exception during cleanup
      print('Error disposing category service: $e');
    }
  }
}
