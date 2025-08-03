import 'package:Shartflix/core/init/application_initialize.dart';
import 'package:Shartflix/core/init/language/product_localization.dart';
import 'package:Shartflix/core/init/router/go_router_provider.dart';
import 'package:Shartflix/core/init/theme/custom_dark_theme.dart';
import 'package:Shartflix/core/init/theme/custom_light_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Uses DevicePreview for testing on different devices.
Future<void> main() async {
  await ApplicationInitialize().make();
  runApp(
    DevicePreview(
      builder: (context) => ProductLocalization(child: const _MyApp()),
    ),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterProvider,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: CustomLightTheme().themeData,
      darkTheme: CustomDarkTheme().themeData,
      locale: context.locale,
      title: 'Material App',
      debugShowCheckedModeBanner: false,
    );
  }
}
