import 'package:hive_flutter/hive_flutter.dart';

part 'category_models.g.dart';

/// Category model for Hive storage.
/// This model represents a category with its subcategories.
///
/// Usage Example:
/// ```dart
/// final category = CategoryModel(
///   id: 'income',
///   name: 'Income',
///   type: CategoryType.main,
///   subcategories: ['Salary', 'Freelance', 'Business'],
/// );
/// ```
@HiveType(typeId: 3)
class CategoryModel extends HiveObject {
  /// Unique identifier for the category
  @HiveField(0)
  final String id;

  /// Display name of the category
  @HiveField(1)
  final String name;

  /// Type of category (main or sub)
  @HiveField(2)
  final String type;

  /// List of subcategory names (only for main categories)
  @HiveField(3)
  final List<String> subcategories;

  /// Parent category ID (only for subcategories)
  @HiveField(4)
  final String? parentId;

  /// Icon name for the category
  @HiveField(5)
  final String? icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.subcategories = const [],
    this.parentId,
    this.icon,
  });

  /// Creates a copy of this category with updated fields
  CategoryModel copyWith({
    String? id,
    String? name,
    String? type,
    List<String>? subcategories,
    String? parentId,
    String? icon,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      subcategories: subcategories ?? this.subcategories,
      parentId: parentId ?? this.parentId,
      icon: icon ?? this.icon,
    );
  }

  /// Converts to JSON for API communication
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'subcategories': subcategories,
      'parentId': parentId,
      'icon': icon,
    };
  }

  /// Creates from JSON data
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      subcategories: List<String>.from(json['subcategories'] ?? []),
      parentId: json['parentId'] as String?,
      icon: json['icon'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.parentId == parentId;
  }

  @override
  int get hashCode {
    return Object.hash(id, name, type, parentId);
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, type: $type, subcategories: $subcategories, parentId: $parentId)';
  }
}

/// Category type enumeration
enum CategoryType { main, sub }
