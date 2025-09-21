/// Base abstract class for all failure types in the application.
///
/// This class follows the Clean Architecture principle by providing a common
/// interface for all error handling across the application. It implements
/// proper equality comparison and toString methods.
///
/// Usage Example:
/// ```dart
/// class ServerFailure extends Failure {
///   const ServerFailure([String? message]) : super(message);
/// }
///
/// // Usage in repository
/// return Left(ServerFailure('Unable to connect to server'));
/// ```
abstract class Failure {
  /// Optional error message providing details about the failure
  final String? message;

  /// Constructor for Failure class
  ///
  /// Parameters:
  /// - [message]: Optional descriptive message about the failure
  const Failure([this.message]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => message ?? 'Unknown failure occurred';
}

/// Failure type for server-related errors.
///
/// This failure is used when API calls fail, network requests timeout,
/// or server returns error responses. It's commonly used in remote data sources.
///
/// Usage Example:
/// ```dart
/// try {
///   final response = await apiClient.get('/dashboard');
///   return response;
/// } catch (e) {
///   return Left(ServerFailure('Failed to fetch dashboard data: ${e.toString()}'));
/// }
/// ```
class ServerFailure extends Failure {
  /// Constructor for server failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the server error
  const ServerFailure([super.message]);
}

/// Failure type for cache-related errors.
///
/// This failure is used when local storage operations fail, such as
/// reading from SharedPreferences, SQLite database errors, or file system issues.
/// It's commonly used in local data sources.
///
/// Usage Example:
/// ```dart
/// try {
///   final cachedData = await sharedPreferences.getString('dashboard_data');
///   return cachedData;
/// } catch (e) {
///   return Left(CacheFailure('Failed to read cached data: ${e.toString()}'));
/// }
/// ```
class CacheFailure extends Failure {
  /// Constructor for cache failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the cache error
  const CacheFailure([super.message]);
}

/// Failure type for network connectivity issues.
///
/// This failure is used when the device has no internet connection
/// or network is unreachable. It helps distinguish between server errors
/// and connectivity issues.
///
/// Usage Example:
/// ```dart
/// if (!await networkInfo.isConnected) {
///   return Left(NetworkFailure('No internet connection available'));
/// }
/// ```
class NetworkFailure extends Failure {
  /// Constructor for network failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the network error
  const NetworkFailure([super.message]);
}

/// Failure type for validation errors.
///
/// This failure is used when input validation fails, such as invalid
/// email format, password requirements not met, or business rule violations.
/// It's commonly used in use cases and form validation.
///
/// Usage Example:
/// ```dart
/// if (email.isEmpty || !email.contains('@')) {
///   return Left(ValidationFailure('Please enter a valid email address'));
/// }
/// ```
class ValidationFailure extends Failure {
  /// Constructor for validation failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the validation error
  const ValidationFailure([super.message]);
}

/// Failure type for authentication and authorization errors.
///
/// This failure is used when user authentication fails, tokens are invalid,
/// or user doesn't have permission to access certain resources.
/// It's commonly used in auth-related operations.
///
/// Usage Example:
/// ```dart
/// if (token == null || token.isExpired) {
///   return Left(AuthFailure('User session expired. Please login again'));
/// }
/// ```
class AuthFailure extends Failure {
  /// Constructor for authentication failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the authentication error
  const AuthFailure([super.message]);
}

/// Failure type for database-related errors.
///
/// This failure is used when database operations fail, such as
/// SQL queries failing, database connection issues, or data integrity violations.
/// It's commonly used in local data sources that interact with databases.
///
/// Usage Example:
/// ```dart
/// try {
///   await database.insert('transactions', transactionData);
/// } catch (e) {
///   return Left(DatabaseFailure('Failed to save transaction: ${e.toString()}'));
/// }
/// ```
class DatabaseFailure extends Failure {
  /// Constructor for database failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the database error
  const DatabaseFailure([super.message]);
}

/// Failure type for general unexpected errors.
///
/// This failure is used as a fallback for unexpected errors that don't
/// fit into specific categories. It should be used sparingly and only
/// when the error type is truly unknown.
///
/// Usage Example:
/// ```dart
/// try {
///   // Some operation
/// } catch (e) {
///   return Left(GeneralFailure('An unexpected error occurred: ${e.toString()}'));
/// }
/// ```
class GeneralFailure extends Failure {
  /// Constructor for general failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the general error
  const GeneralFailure([super.message]);
}

/// Failure type for business logic violations.
///
/// This failure is used when business rules are violated, such as
/// insufficient funds for a transaction, invalid operation sequences,
/// or domain-specific constraint violations.
///
/// Usage Example:
/// ```dart
/// if (accountBalance < transactionAmount) {
///   return Left(BusinessFailure('Insufficient funds for this transaction'));
/// }
/// ```
class BusinessFailure extends Failure {
  /// Constructor for business failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the business rule violation
  const BusinessFailure([super.message]);
}

/// Failure type for unknown or unexpected errors.
///
/// This failure is used when an error occurs that doesn't fit into
/// any specific category or when the exact cause is unknown.
///
/// Usage Example:
/// ```dart
/// try {
///   // Some operation
/// } catch (e) {
///   return Left(UnknownFailure('An unexpected error occurred: ${e.toString()}'));
/// }
/// ```
class UnknownFailure extends Failure {
  /// Constructor for unknown failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing the unknown error
  const UnknownFailure([super.message]);
}

/// Failure type for resource not found errors.
///
/// This failure is used when a requested resource (like a transaction,
/// user, or data record) cannot be found in the system.
///
/// Usage Example:
/// ```dart
/// final transaction = await getTransaction(id);
/// if (transaction == null) {
///   return Left(NotFoundFailure('Transaction with ID $id not found'));
/// }
/// ```
class NotFoundFailure extends Failure {
  /// Constructor for not found failure
  ///
  /// Parameters:
  /// - [message]: Optional message describing what was not found
  const NotFoundFailure([super.message]);
}
