import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'bank_model.freezed.dart';
part 'bank_model.g.dart';

/// Bank model for storing selected bank SMS conversation numbers.
/// This model represents a bank that the user has selected to track
/// SMS messages from for transaction import.
///
/// Usage Example:
/// ```dart
/// final bank = BankModel(
///   id: 'bank_1',
///   name: 'My Bank',
///   phoneNumber: '+1234567890',
///   isActive: true,
///   createdAt: DateTime.now(),
/// );
/// ```
@HiveType(typeId: 3)
@freezed
class BankModel with _$BankModel {
  /// Creates a bank model with all required fields.
  ///
  /// Parameters:
  /// - [id]: Unique identifier for the bank
  /// - [name]: Display name for the bank
  /// - [phoneNumber]: SMS sender phone number for this bank
  /// - [isActive]: Whether this bank is currently active for SMS tracking
  /// - [createdAt]: When this bank was added
  /// - [updatedAt]: When this bank was last updated
  const factory BankModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String phoneNumber,
    @HiveField(3) @Default(true) bool isActive,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime updatedAt,
  }) = _BankModel;

  /// Creates a BankModel from JSON data.
  ///
  /// Parameters:
  /// - [json]: Map containing bank data
  ///
  /// Returns:
  /// - [BankModel]: Parsed bank model
  factory BankModel.fromJson(Map<String, dynamic> json) =>
      _$BankModelFromJson(json);
}
