/// Parameter class for use cases that don't require any parameters.
/// This class follows the convention of providing a parameter object
/// even when no parameters are needed, maintaining consistency
/// across all use cases in the application.
///
/// Usage Example:
/// ```dart
/// final result = await useCase.call(NoParams());
/// ```
class NoParams {
  /// Creates a new instance of NoParams.
  /// This constructor creates an empty parameter object
  /// for use cases that don't require any input parameters.
  const NoParams();
}
