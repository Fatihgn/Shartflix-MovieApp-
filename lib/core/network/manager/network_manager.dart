import 'dart:developer';

import 'package:Shartflix/core/network/exceptions/api_exceptions.dart';
import 'package:Shartflix/core/network/response/api_response.dart';

import 'package:dio/dio.dart';

/// Network manager to handle API requests.
class NetworkManager {
  NetworkManager(this._dio);
  final Dio _dio;

  /// Sends a GET request and parses the response.
  Future<ApiResponse<T>> get<T>(
    String path, {
    required T Function(dynamic data) parser,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      return Success(parser(response.data));
    } on DioException catch (e) {
      log('DioException in GET $path: ${e.message}');
      return Failure(ApiException.fromDioError(e));
    } catch (e) {
      log('Unhandled exception in GET $path: $e');
      return Failure(UnknownException(message: e.toString()));
    }
  }

  /// Sends a POST request with a body and parses the response.
  Future<ApiResponse<T>> postP<T>(
    String path, {
    required T Function(dynamic data) parser,
    dynamic body,
  }) async {
    try {
      final response = await _dio.post<dynamic>(path, data: body);
      return Success(parser(response.data));
    } on DioException catch (e) {
      log('DioException in POST $path: ${e.message}');
      return Failure(ApiException.fromDioError(e));
    } catch (e) {
      log('Unhandled exception in POST $path: $e');
      return Failure(UnknownException(message: e.toString()));
    }
  }

  /// Sends a POST request without a body and parses the response.
  Future<ApiResponse<T>> post<T>(String path, {dynamic body}) async {
    try {
      final response = await _dio.post<dynamic>(path, data: body);
      return Success(response.data as T);
    } on DioException catch (e) {
      log('DioException in empty POST $path: ${e.message}');
      return Failure(ApiException.fromDioError(e));
    } catch (e) {
      log('Unhandled exception in empty POST $path: $e');
      return Failure(UnknownException(message: e.toString()));
    }
  }
}
