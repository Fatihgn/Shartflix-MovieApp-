import 'package:dio/dio.dart';

/// Base class for all API-related exceptions
class ApiException implements Exception {
  /// Creates an [ApiException] with the given [message]
  ApiException({required this.message});

  /// Creates an [ApiException] from a [DioException]
  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);
      case DioExceptionType.cancel:
        return RequestCancelledException();
      case DioExceptionType.connectionError:
        return NoInternetConnectionException();
      case DioExceptionType.unknown:
        return UnknownException();
      case DioExceptionType.badCertificate:
        return BadCertificateException();
    }
  }

  /// The error message associated with this exception
  final String message;

  /// Handles different HTTP status codes and returns appropriate exceptions
  static ApiException _handleResponseError(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: _getErrorMessage(data) ?? 'Bad request',
        );
      case 401:
        return UnauthorizedException(
          message: _getErrorMessage(data) ?? 'Unauthorized',
        );
      case 403:
        return ForbiddenException(
          message: _getErrorMessage(data) ?? 'Forbidden',
        );
      case 404:
        return NotFoundException(
          message: _getErrorMessage(data) ?? 'Not found',
        );
      case 409:
        return ConflictException(message: _getErrorMessage(data) ?? 'Conflict');
      case 422:
        return ValidationException(
          message: _getErrorMessage(data) ?? 'Validation failed',
          errors: data is Map<String, dynamic>
              ? data['errors'] as Map<String, dynamic>?
              : null,
        );
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException(
          message: _getErrorMessage(data) ?? 'Server error',
        );
      default:
        return UnknownException(
          message: _getErrorMessage(data) ?? 'Unknown error occurred',
        );
    }
  }

  /// Extracts error message from response data
  static String? _getErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['response']['message'] as String? ??
          data['response']['error'] as String?;
    }
    return data?.toString();
  }

  @override
  String toString() => message;
}

/// Exception thrown when there is no internet connection
class NoInternetConnectionException extends ApiException {
  /// Creates a [NoInternetConnectionException]
  NoInternetConnectionException()
    : super(message: 'No internet connection available');
}

/// Exception thrown when the request times out
class TimeoutException extends ApiException {
  /// Creates a [TimeoutException]
  TimeoutException() : super(message: 'Request timed out');
}

/// Exception thrown when the request is cancelled
class RequestCancelledException extends ApiException {
  /// Creates a [RequestCancelledException]
  RequestCancelledException() : super(message: 'Request was cancelled');
}

/// Exception thrown when the server returns a 400 status code
class BadRequestException extends ApiException {
  /// Creates a [BadRequestException]
  BadRequestException({required super.message});
}

/// Exception thrown when the server returns a 401 status code
class UnauthorizedException extends ApiException {
  /// Creates a [UnauthorizedException]
  UnauthorizedException({required super.message});
}

/// Exception thrown when the server returns a 403 status code
class ForbiddenException extends ApiException {
  /// Creates a [ForbiddenException]
  ForbiddenException({required super.message});
}

/// Exception thrown when the server returns a 404 status code
class NotFoundException extends ApiException {
  /// Creates a [NotFoundException]
  NotFoundException({required super.message});
}

/// Exception thrown when the server returns a 409 status code
class ConflictException extends ApiException {
  /// Creates a [ConflictException]
  ConflictException({required super.message});
}

/// Exception thrown when the server returns a 422 status code
class ValidationException extends ApiException {
  /// Creates a [ValidationException]
  ValidationException({required super.message, this.errors});

  /// Additional validation errors, if any
  final Map<String, dynamic>? errors;
}

/// Exception thrown when the server returns a 5xx status code
class ServerException extends ApiException {
  /// Creates a [ServerException]
  ServerException({required super.message});
}

/// Exception thrown when the server certificate is invalid
class BadCertificateException extends ApiException {
  /// Creates a [BadCertificateException]
  BadCertificateException() : super(message: 'Invalid server certificate');
}

/// Exception thrown when an unknown error occurs
class UnknownException extends ApiException {
  /// Creates a [UnknownException]
  UnknownException({String? message})
    : super(message: message ?? 'An unknown error occurred');
}
