import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_entity.freezed.dart';

/// Bank entity representing a selected bank for SMS tracking.
/// This entity contains the core data structure for banks
/// used throughout the SMS Import feature.
///
/// Usage Example:
/// ```dart
/// final bank = BankEntity(
///   id: 'bank_1',
///   name: 'My Bank',
///   phoneNumber: '+1234567890',
///   isActive: true,
/// );
/// ```
@freezed
class BankEntity with _$BankEntity {
  /// Creates a bank entity with all required fields.
  ///
  /// Parameters:
  /// - [id]: Unique identifier for the bank
  /// - [name]: Display name for the bank
  /// - [phoneNumber]: SMS sender phone number for this bank
  /// - [isActive]: Whether this bank is currently active for SMS tracking
  const factory BankEntity({
    required String id,
    required String name,
    required String phoneNumber,
    @Default(true) bool isActive,
  }) = _BankEntity;
}
