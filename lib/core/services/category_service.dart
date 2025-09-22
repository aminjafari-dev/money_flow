import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_flow/core/error/exceptions.dart';
import 'package:money_flow/core/services/category_models.dart';

/// Service for managing categories and subcategories.
/// This service handles all category operations including initialization,
/// CRUD operations, and local storage management.
///
/// Usage Example:
/// ```dart
/// final categoryService = CategoryService();
/// await categoryService.initialize();
///
/// // Get main categories
/// final mainCategories = await categoryService.getMainCategories();
///
/// // Get subcategories for a category
/// final subcategories = await categoryService.getSubcategories('income');
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
  /// This method sets up the main categories and their subcategories.
  Future<void> _initializeDefaultCategories() async {
    try {
      // Define the 4 main categories as per your requirement
      final defaultCategories = [
        // Income - Main category for all income types
        CategoryModel(
          id: 'income',
          name: 'Income',
          type: 'main',
          icon: 'income_icon',
          subcategories: [
            'Salary',
            'Freelance',
            'Business',
            'Investment Returns',
            'Bonus',
            'Gift',
            'Rental Income',
            'Refund',
            'Other Income',
          ],
        ),

        // Expenses - Main category for all expense types
        CategoryModel(
          id: 'expenses',
          name: 'Expenses',
          type: 'main',
          icon: 'expense_icon',
          subcategories: [
            'Food & Dining',
            'Transportation',
            'Shopping',
            'Entertainment',
            'Bills & Utilities',
            'Healthcare',
            'Education',
            'Travel',
            'Personal Care',
            'Home & Garden',
            'Insurance',
            'Other Expenses',
          ],
        ),

        // Charity - Main category for charitable donations
        CategoryModel(
          id: 'charity',
          name: 'Charity',
          type: 'main',
          icon: 'charity_icon',
          subcategories: [
            'Religious Donations',
            'Humanitarian Aid',
            'Education Support',
            'Healthcare Support',
            'Environmental Causes',
            'Animal Welfare',
            'Community Support',
            'Other Charity',
          ],
        ),

        // Investments - Main category for all investment types
        CategoryModel(
          id: 'investments',
          name: 'Investments',
          type: 'main',
          icon: 'investment_icon',
          subcategories: [
            'Stocks',
            'Bonds',
            'Mutual Funds',
            'Real Estate',
            'Cryptocurrency',
            'Savings Account',
            'Fixed Deposit',
            'Gold',
            'Other Investments',
          ],
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
  ///
  /// Parameters:
  /// - [mainCategoryId]: ID of the main category
  ///
  /// Returns:
  /// - [List<String>]: List of subcategory names
  ///
  /// Usage Example:
  /// ```dart
  /// final subcategories = await categoryService.getSubcategories('income');
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

      return category.subcategories;
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
  ///
  /// Parameters:
  /// - [mainCategoryId]: ID of the main category
  /// - [subcategoryName]: Name of the subcategory to add
  ///
  /// Usage Example:
  /// ```dart
  /// await categoryService.addSubcategory('income', 'Consulting');
  /// ```
  Future<void> addSubcategory(
    String mainCategoryId,
    String subcategoryName,
  ) async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Get the main category
      final category = _categoryBox!.get(mainCategoryId);
      if (category == null || category.type != 'main') {
        throw CacheException('Main category not found: $mainCategoryId');
      }

      // Check if subcategory already exists
      if (category.subcategories.contains(subcategoryName)) {
        return; // Already exists
      }

      // Add subcategory
      final updatedSubcategories = [...category.subcategories, subcategoryName];
      final updatedCategory = category.copyWith(
        subcategories: updatedSubcategories,
      );

      // Store updated category
      await _categoryBox!.put(mainCategoryId, updatedCategory);
    } catch (e) {
      throw CacheException('Failed to add subcategory: $e');
    }
  }

  /// Determines the main category for a given subcategory.
  /// This is used for dashboard categorization.
  ///
  /// Parameters:
  /// - [subcategoryName]: Name of the subcategory
  ///
  /// Returns:
  /// - [String?]: Main category ID or null if not found
  ///
  /// Usage Example:
  /// ```dart
  /// final mainCategory = await categoryService.getMainCategoryForSubcategory('Salary');
  /// // Returns: 'income'
  /// ```
  Future<String?> getMainCategoryForSubcategory(String subcategoryName) async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Get all main categories
      final mainCategories = await getMainCategories();

      // Find the main category that contains this subcategory
      for (final category in mainCategories) {
        if (category.subcategories.contains(subcategoryName)) {
          return category.id;
        }
      }

      return null; // Not found
    } catch (e) {
      throw CacheException('Failed to get main category for subcategory: $e');
    }
  }

  /// Gets all subcategories across all main categories.
  /// This is useful for autocomplete or search functionality.
  ///
  /// Returns:
  /// - [List<String>]: List of all subcategory names
  ///
  /// Usage Example:
  /// ```dart
  /// final allSubcategories = await categoryService.getAllSubcategories();
  /// ```
  Future<List<String>> getAllSubcategories() async {
    try {
      // Ensure box is initialized
      if (_categoryBox == null) {
        await initialize();
      }

      // Get all main categories
      final mainCategories = await getMainCategories();

      // Collect all subcategories
      final allSubcategories = <String>[];
      for (final category in mainCategories) {
        allSubcategories.addAll(category.subcategories);
      }

      return allSubcategories;
    } catch (e) {
      throw CacheException('Failed to get all subcategories: $e');
    }
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
