import 'dart:developer' as developer;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// A custom logging service.
/// This class enables the application to log at different levels.
/// It prints colored logs to the console in debug mode and sends only
/// critical errors to Firebase Crashlytics in release mode.
@immutable
final class CustomLogger {
  /// Private constructor for creating a singleton instance.
  CustomLogger._();

  static final CustomLogger _instance = CustomLogger._();

  static CustomLogger get instance => _instance;

  /// Configure the logger package.
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      printTime: true, // Whether to print the timestamp
    ),
  );

  /// Use this method to print a message to the console.
  /// It only works in debug mode.
  void log(String message) {
    if (kDebugMode) {
      _logger.d(message);
    }
  }

  /// Use this method for informational logs.
  /// It only works in debug mode.
  void info(String message) {
    if (kDebugMode) {
      _logger.i(message);
    }
  }

  /// Use this method for warning logs.
  /// It only works in debug mode.
  void warn(String message) {
    if (kDebugMode) {
      _logger.w(message);
    }
  }

  /// Use this method for error logs.
  /// The error is both logged to the console in debug mode and sent to
  /// Crashlytics in release mode.
  void error(dynamic error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.e(error.toString(), error: error, stackTrace: stackTrace);
    }

    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

  /// Use this method for fatal errors that cause the application to crash.
  /// The error is both logged to the console in debug mode and sent to
  /// Crashlytics as a fatal error in release mode.
  void fatal(dynamic error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.f(error.toString(), error: error, stackTrace: stackTrace);
    }

    if (kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    }
  }
}

// A global logger instance
final CustomLogger customLogger = CustomLogger.instance;
