import 'package:Shartflix/feature/home/view/home_view.dart';
import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/feature/login/view/login_view.dart';
import 'package:Shartflix/feature/main_page/view/main_page_view.dart';
import 'package:Shartflix/feature/profile/view/profile_view.dart';
import 'package:Shartflix/feature/register/view/register_view.dart';
import 'package:Shartflix/feature/splash/view/splash_view.dart';
import 'package:Shartflix/feature/upload_photo/view/upload_photo_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// The [goRouterProvider] is a GoRouter instance that defines the navigation structure of the app.
final goRouterProvider = GoRouter(
  initialLocation: RouteName.splash,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: RouteName.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: RouteName.register,
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: RouteName.uploadPhoto,
      builder: (context, state) => const UploadPhotoView(),
    ),

    /// that allows for nested navigation within the app.
    /// It contains two branches: one for the home view and another for the profile view.
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.profile,
              builder: (context, state) => const ProfileView(),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return MainPageView(navigationShell: navigationShell);
      },
    ),
  ],
);
