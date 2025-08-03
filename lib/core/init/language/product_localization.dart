import 'package:Shartflix/core/utility/constants/enums/locales.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
/// sh script/lang.sh
/// Product localization manager
final class ProductLocalization extends EasyLocalization {
  ProductLocalization({required super.child, super.key})
    : super(
        supportedLocales: _supportedItems,
        path: _translationPath,
        useOnlyLangCode: true,
      );

  static final List<Locale> _supportedItems = [
    Locales.tr.locale,
    Locales.en.locale,
  ];
  static const String _translationPath = 'asset/translations';

  /// Updates the app language
  static void updateLanguage({
    required BuildContext context,
    required Locales value,
  }) => context.setLocale(value.locale);
}
