import 'package:flutter/material.dart';

/// Project locales enumeration
enum Locales {
  tr(Locale('tr', 'TR')),
  en(Locale('en', 'US'));

  final Locale locale;
  const Locales(this.locale);

  /// Project supported locales
  static final List<Locale> supportedLocales = [
    Locales.tr.locale,
    Locales.en.locale,
  ];
}
