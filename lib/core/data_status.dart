import 'package:dartz/dartz.dart';
import 'package:money_flow/core/error/failures.dart';

/// A generic data status class that wraps Either[Failure, T] for better error handling.
/// This class provides a consistent way to handle success and failure states throughout the application.
///
/// Usage Example:
/// ```dart
/// // Success case
/// final success = DataSuccess<String>('Hello World');
///
/// // Failure case
/// final failure = DataFailed<String>(ServerFailure());
///
/// // Using with Either
/// final result = DataStatus.fromEither(eitherResult);
/// ```
class DataStatus<T> {
  final Either<Failure, T> _either;

  /// Creates a DataStatus from an Either[Failure, T].
  ///
  /// Parameters:
  /// - [either]: The Either object containing success or failure data
  ///
  /// Usage Example:
  /// ```dart
  /// final status = DataStatus.fromEither(eitherResult);
  /// ```
  const DataStatus(this._either);

  /// Creates a DataStatus from an Either[Failure, T].
  ///
  /// Parameters:
  /// - [either]: The Either object containing success or failure data
  ///
  /// Returns:
  /// - [DataStatus<T>]: A new DataStatus instance
  ///
  /// Usage Example:
  /// ```dart
  /// final status = DataStatus.fromEither(eitherResult);
  /// ```
  factory DataStatus.fromEither(Either<Failure, T> either) {
    return DataStatus(either);
  }

  /// Creates a successful DataStatus with the given data.
  ///
  /// Parameters:
  /// - [data]: The successful data
  ///
  /// Returns:
  /// - [DataStatus<T>]: A successful DataStatus
  ///
  /// Usage Example:
  /// ```dart
  /// final success = DataStatus.success('Hello World');
  /// ```
  factory DataStatus.success(T data) {
    return DataStatus(Right(data));
  }

  /// Creates a failed DataStatus with the given failure.
  ///
  /// Parameters:
  /// - [failure]: The failure object
  ///
  /// Returns:
  /// - [DataStatus<T>]: A failed DataStatus
  ///
  /// Usage Example:
  /// ```dart
  /// final failure = DataStatus.failure(ServerFailure());
  /// ```
  factory DataStatus.failure(Failure failure) {
    return DataStatus(Left(failure));
  }

  /// Returns true if this DataStatus represents a success.
  ///
  /// Returns:
  /// - [bool]: True if successful, false otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// if (status.isSuccess) {
  ///   print('Operation succeeded');
  /// }
  /// ```
  bool get isSuccess => _either.isRight();

  /// Returns true if this DataStatus represents a failure.
  ///
  /// Returns:
  /// - [bool]: True if failed, false otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// if (status.isFailure) {
  ///   print('Operation failed');
  /// }
  /// ```
  bool get isFailure => _either.isLeft();

  /// Returns the data if this is a success, null otherwise.
  ///
  /// Returns:
  /// - [T?]: The data if successful, null otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// final data = status.data;
  /// if (data != null) {
  ///   print('Data: $data');
  /// }
  /// ```
  T? get data => _either.fold((_) => null, (data) => data);

  /// Returns the failure if this is a failure, null otherwise.
  ///
  /// Returns:
  /// - [Failure?]: The failure if failed, null otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// final failure = status.failure;
  /// if (failure != null) {
  ///   print('Error: ${failure.message}');
  /// }
  /// ```
  Failure? get failure => _either.fold((failure) => failure, (_) => null);

  /// Returns the error message if this is a failure, null otherwise.
  ///
  /// Returns:
  /// - [String?]: The error message if failed, null otherwise
  ///
  /// Usage Example:
  /// ```dart
  /// final error = status.error;
  /// if (error != null) {
  ///   print('Error: $error');
  /// }
  /// ```
  String? get error => failure?.message;

  /// Applies a function to the data if this is a success.
  ///
  /// Parameters:
  /// - [f]: Function to apply to the data
  ///
  /// Returns:
  /// - [DataStatus<R>]: New DataStatus with transformed data
  ///
  /// Usage Example:
  /// ```dart
  /// final transformed = status.map((data) => data.toUpperCase());
  /// ```
  DataStatus<R> map<R>(R Function(T) f) {
    return DataStatus(_either.map(f));
  }

  /// Applies a function to the failure if this is a failure.
  ///
  /// Parameters:
  /// - [f]: Function to apply to the failure
  ///
  /// Returns:
  /// - [DataStatus<T>]: New DataStatus with transformed failure
  ///
  /// Usage Example:
  /// ```dart
  /// final transformed = status.mapFailure((failure) => CustomFailure());
  /// ```
  DataStatus<T> mapFailure(Failure Function(Failure) f) {
    return DataStatus(
      _either.fold((failure) => Left(f(failure)), (data) => Right(data)),
    );
  }

  /// Folds this DataStatus into a single value.
  ///
  /// Parameters:
  /// - [onFailure]: Function to call if this is a failure
  /// - [onSuccess]: Function to call if this is a success
  ///
  /// Returns:
  /// - [R]: The result of applying the appropriate function
  ///
  /// Usage Example:
  /// ```dart
  /// final result = status.fold(
  ///   (failure) => 'Error: ${failure.message}',
  ///   (data) => 'Success: $data',
  /// );
  /// ```
  R fold<R>(R Function(Failure) onFailure, R Function(T) onSuccess) {
    return _either.fold(onFailure, onSuccess);
  }

  /// Returns the underlying Either object.
  ///
  /// Returns:
  /// - [Either[Failure, T]]: The underlying Either
  ///
  /// Usage Example:
  /// ```dart
  /// final either = status.either;
  /// ```
  Either<Failure, T> get either => _either;
}

/// A successful DataStatus.
/// This class represents a successful operation result.
///
/// Usage Example:
/// ```dart
/// final success = DataSuccess<String>('Hello World');
/// ```
class DataSuccess<T> extends DataStatus<T> {
  /// Creates a successful DataStatus with the given data.
  ///
  /// Parameters:
  /// - [data]: The successful data
  ///
  /// Usage Example:
  /// ```dart
  /// final success = DataSuccess<String>('Hello World');
  /// ```
  DataSuccess(T data) : super(Right(data));
}

/// A failed DataStatus.
/// This class represents a failed operation result.
///
/// Usage Example:
/// ```dart
/// final failure = DataFailed<String>(ServerFailure());
/// ```
class DataFailed<T> extends DataStatus<T> {
  /// Creates a failed DataStatus with the given failure.
  ///
  /// Parameters:
  /// - [failure]: The failure object
  ///
  /// Usage Example:
  /// ```dart
  /// final failure = DataFailed<String>(ServerFailure());
  /// ```
  DataFailed(Failure failure) : super(Left(failure));
}
