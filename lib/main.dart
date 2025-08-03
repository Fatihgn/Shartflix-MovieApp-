import 'package:Shartflix/core/providers/app_providers.dart';
import 'package:Shartflix/core/service/auth_service.dart';
import 'package:Shartflix/core/service/movie_service.dart';
import 'package:Shartflix/feature/home/view/home_view.dart';
import 'package:Shartflix/core/init/application_initialize.dart';
import 'package:Shartflix/core/init/language/product_localization.dart';
import 'package:Shartflix/core/init/router/go_router_provider.dart';
import 'package:Shartflix/core/init/theme/custom_dark_theme.dart';
import 'package:Shartflix/core/init/theme/custom_light_theme.dart';
import 'package:Shartflix/feature/home/view_model/bloc/home_bloc.dart';
import 'package:Shartflix/feature/login/view_model/bloc/login_bloc.dart';
import 'package:Shartflix/feature/profile/view_model/bloc/profile_bloc.dart';
import 'package:Shartflix/feature/upload_photo/view_model/bloc/upload_photo_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await ApplicationInitialize().make();
  runApp(
    /// Initializes the application with localization and screen size configuration.
    ScreenUtilInit(
      designSize: const Size(402, 844),
      child: ProductLocalization(child: const _MyApp()),
    ),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Provides the necessary repositories and blocs for the application.
    return MultiRepositoryProvider(
      providers: AppRepositoryProviders.providers,

      /// Provides the necessary blocs for the application.
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UploadPhotoBloc(context.read<AuthService>()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(context.read<MovieService>()),
          ),
          BlocProvider(
            create: (context) => HomeBloc(context.read<MovieService>()),
          ),
        ],

        /// The main MaterialApp that sets up the router and theme.
        child: MaterialApp.router(
          routerConfig: goRouterProvider,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: CustomLightTheme().themeData,
          darkTheme: CustomDarkTheme().themeData,
          title: 'Material App',
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
