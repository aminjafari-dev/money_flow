/// Custom exceptions for the Money Flow application.
///
/// This file contains all custom exception classes used throughout the application.
/// These exceptions are thrown by data sources and caught by repositories,
/// which then convert them to appropriate Failure objects following Clean Architecture principles.
///
/// Usage Example:
/// ```dart
/// try {
///   // Some operation that might fail
///   final data = await someOperation();
/// } on CacheException catch (e) {
///   // Handle cache-specific errors
///   return Left(CacheFailure(e.message));
/// } on ServerException catch (e) {
///   // Handle server-specific errors
///   return Left(ServerFailure(e.message));
/// }
/// ```

/// Base exception class for all custom exceptions in the application.
///
/// This abstract class provides a common structure for all custom exceptions,
/// ensuring consistent error handling across the application.
///
/// Usage Example:
/// ```dart
/// class CustomException extends AppException {
///   const CustomException(super.message);
/// }
/// ```
abstract class AppException implements Exception {
  /// The error message describing what went wrong
  final String message;

  /// Constructor for AppException
  ///
  /// Parameters:
  /// - [message]: Descriptive error message
  const AppException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when cache operations fail.
///
/// This exception is used when local storage operations encounter errors,
/// such as reading from SharedPreferences, SQLite database issues, or file system problems.
/// It's commonly thrown by local data sources and caught by repositories.
///
/// Usage Example:
/// ```dart
/// try {
///   await sharedPreferences.setString('key', 'value');
/// } catch (e) {
///   throw CacheException('Failed to save data to cache: $e');
/// }
/// ```
class CacheException extends AppException {
  /// Constructor for CacheException
  ///
  /// Parameters:
  /// - [message]: Error message describing the cache operation failure
  const CacheException(super.message);
}

/// Exception thrown when server operations fail.
///
/// This exception is used when API calls fail, network requests timeout,
/// or server returns error responses. It's commonly thrown by remote data sources.
///
/// Usage Example:
/// ```dart
/// try {
///   final response = await httpClient.get('/api/data');
///   if (response.statusCode != 200) {
///     throw ServerException('Server returned ${response.statusCode}');
///   }
/// } catch (e) {
///   throw ServerException('Failed to fetch data from server: $e');
/// }
/// ```
class ServerException extends AppException {
  /// Constructor for ServerException
  ///
  /// Parameters:
  /// - [message]: Error message describing the server operation failure
  const ServerException(super.message);
}

/// Exception thrown when network connectivity issues occur.
///
/// This exception is used when the device has no internet connection
/// or network is unreachable. It helps distinguish between server errors
/// and connectivity issues.
///
/// Usage Example:
/// ```dart
/// if (!await networkInfo.isConnected) {
///   throw NetworkException('No internet connection available');
/// }
/// ```
class NetworkException extends AppException {
  /// Constructor for NetworkException
  ///
  /// Parameters:
  /// - [message]: Error message describing the network connectivity issue
  const NetworkException(super.message);
}

/// Exception thrown when validation fails.
///
/// This exception is used when input validation fails, such as invalid
/// email format, password requirements not met, or business rule violations.
/// It's commonly used in use cases and form validation.
///
/// Usage Example:
/// ```dart
/// if (email.isEmpty || !email.contains('@')) {
///   throw ValidationException('Please enter a valid email address');
/// }
/// ```
class ValidationException extends AppException {
  /// Constructor for ValidationException
  ///
  /// Parameters:
  /// - [message]: Error message describing the validation failure
  const ValidationException(super.message);
}

/// Exception thrown when authentication or authorization fails.
///
/// This exception is used when user authentication fails, tokens are invalid,
/// or user doesn't have permission to access certain resources.
/// It's commonly used in auth-related operations.
///
/// Usage Example:
/// ```dart
/// if (token == null || token.isExpired) {
///   throw AuthException('User session expired. Please login again');
/// }
/// ```
class AuthException extends AppException {
  /// Constructor for AuthException
  ///
  /// Parameters:
  /// - [message]: Error message describing the authentication failure
  const AuthException(super.message);
}

/// Exception thrown when database operations fail.
///
/// This exception is used when database operations fail, such as
/// SQL queries failing, database connection issues, or data integrity violations.
/// It's commonly used in local data sources that interact with databases.
///
/// Usage Example:
/// ```dart
/// try {
///   await database.insert('transactions', transactionData);
/// } catch (e) {
///   throw DatabaseException('Failed to save transaction: $e');
/// }
/// ```
class DatabaseException extends AppException {
  /// Constructor for DatabaseException
  ///
  /// Parameters:
  /// - [message]: Error message describing the database operation failure
  const DatabaseException(super.message);
}

/// Exception thrown when business logic violations occur.
///
/// This exception is used when business rules are violated, such as
/// insufficient funds for a transaction, invalid operation sequences,
/// or domain-specific constraint violations.
///
/// Usage Example:
/// ```dart
/// if (accountBalance < transactionAmount) {
///   throw BusinessException('Insufficient funds for this transaction');
/// }
/// ```
class BusinessException extends AppException {
  /// Constructor for BusinessException
  ///
  /// Parameters:
  /// - [message]: Error message describing the business rule violation
  const BusinessException(super.message);
}
