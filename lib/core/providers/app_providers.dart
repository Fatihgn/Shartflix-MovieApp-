import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/init/config/app_environment.dart';
import 'package:Shartflix/core/network/interceptors/logging_interceptor.dart';
import 'package:Shartflix/core/network/manager/network_manager.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/service/movie_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

/// Provides repository instances for the application.
/// This class is used to register and provide instances of various services
/// such as CacheService, NetworkManager, AuthService, and MovieService.
/// It uses the RepositoryProvider from the flutter_bloc package to make these
/// services available throughout the application.
class AppRepositoryProviders {
  static final List<RepositoryProvider> providers = [
    RepositoryProvider<CacheService>(create: (context) => CacheService()),

    RepositoryProvider<Dio>(
      create: (context) {
        final options = BaseOptions(
          baseUrl: AppEnvironmentItems.baseUrl.value,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          contentType: Headers.jsonContentType,
        );

        final dio = Dio(options);

        /// Add interceptors for all requests.
        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest:
                (RequestOptions options, RequestInterceptorHandler handler) {
                  // İstek bilgilerini logla
                  if (kDebugMode) {
                    print('--- HTTP REQUEST ---');
                    print('URL: ${options.baseUrl}${options.path}');
                    print('Method: ${options.method}');
                    print('Headers: ${options.headers}');
                    print('Query Parameters: ${options.queryParameters}');
                    if (options.data != null) {
                      print('Body: ${options.data}');
                    }
                    print('--------------------');
                  }
                  return handler.next(options);
                },
            onResponse: (Response response, ResponseInterceptorHandler handler) {
              // Yanıt bilgilerini logla
              if (kDebugMode) {
                print('--- HTTP RESPONSE ---');
                print(
                  'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
                );
                print('Status Code: ${response.statusCode}');
                print('Response: ${response.data}');
                print('--------------------');
              }
              return handler.next(response);
            },
            onError: (DioException e, ErrorInterceptorHandler handler) {
              // Hata bilgilerini logla
              if (kDebugMode) {
                print('--- HTTP ERROR ---');
                print(
                  'URL: ${e.requestOptions.baseUrl}${e.requestOptions.path}',
                );
                print('Error: ${e.message}');
                if (e.response != null) {
                  print('Status Code: ${e.response?.statusCode}');
                  print('Response: ${e.response?.data}');
                }
                print('-------------------');
              }
              return handler.next(e);
            },
          ),
        );

        /// Add the authentication token interceptor.
        dio.interceptors.add(
          AuthTokenInterceptor(context.read<CacheService>()),
        );

        return dio;
      },
    ),
    RepositoryProvider<NetworkManager>(
      create: (context) => NetworkManager(context.read<Dio>()),
    ),
    RepositoryProvider<AuthService>(
      create: (context) => AuthService(
        context.read<NetworkManager>(),
        context.read<CacheService>(),
      ),
    ),
    RepositoryProvider<MovieService>(
      create: (context) => MovieService(
        context.read<NetworkManager>(),
      ),
    ),
  ];
}
