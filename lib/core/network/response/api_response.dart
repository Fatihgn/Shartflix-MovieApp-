import 'package:Shartflix/core/network/exceptions/api_exceptions.dart';

/// Represents the response from an API call.
sealed class ApiResponse<T> {
  const ApiResponse();
}

/// Represents a successful API response with data.
class Success<T> extends ApiResponse<T> {
  const Success(this.data);

  final T data;
}

/// Represents a failed API response with an error.
class Failure<T> extends ApiResponse<T> {
  const Failure(this.error);

  final ApiException error;
}
