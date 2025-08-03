import 'package:flutter/foundation.dart';
import 'package:gen/gen.dart';

///Aplication environment configuration class.
final class AppEnvironment {
  AppEnvironment.setup({required AppConfiguration config}) {
    _config = config;
  }

  AppEnvironment.general() {
    _config = kDebugMode ? DevEnv() : ProdEnv();
  }
  static late final AppConfiguration _config;
}

enum AppEnvironmentItems {
  baseUrl,
  apiKey;

  String get value {
    try {
      switch (this) {
        case AppEnvironmentItems.baseUrl:
          return AppEnvironment._config.baseUrl;
        case AppEnvironmentItems.apiKey:
          return AppEnvironment._config.apiKey;
      }
    } catch (e) {
      throw Exception('AppEnvironment is not initialized. ');
    }
  }
}
