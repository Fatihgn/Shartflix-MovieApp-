import 'dart:developer';

import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:dio/dio.dart';

/// Interceptor to add authentication token to requests.
class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor(this._cacheService);

  final CacheService _cacheService;
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /// Retrieve the authentication token from the cache service.
    final token = await _cacheService.readToken();
    log('AuthTokenInterceptor: Token: $token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
