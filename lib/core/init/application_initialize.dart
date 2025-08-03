import 'dart:async';
import 'dart:ui';
import 'package:Shartflix/core/init/config/app_environment.dart';
import 'package:Shartflix/core/service/logger/custom_logger.dart';
import 'package:Shartflix/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

@immutable
final class ApplicationInitialize {
  /// Project basic required initializations
  Future<void> make() async {
    WidgetsFlutterBinding.ensureInitialized();

    await runZonedGuarded<Future<void>>(
      () async {
        await _initialize();

        /// Set up Crashlytics error handling
        /// This will catch errors that occur in the Flutter framework
        /// and send them to Firebase Crashlytics.
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };
      },
      (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      },
    );
  }

  static Future<void> _initialize() async {
    /// Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// Ensure that EasyLocalization is initialized
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];

    /// Set preferred orientations for the app
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    /// This will catch errors that occur in the Flutter framework
    /// and send them to Firebase Crashlytics.
    FlutterError.onError = (details) {
      customLogger.error(details.exceptionAsString());
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    AppEnvironment.general();
  }
}
