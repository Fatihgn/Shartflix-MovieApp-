import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/feature/home/view/home_view.dart';
import 'package:Shartflix/feature/splash/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

mixin SplashViewMixin on State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnToken();
  }

  Future<void> _navigateBasedOnToken() async {
    /// Simulate a delay for splash screen effect
    // This can be removed or adjusted based on your actual splash screen requirements
    await Future.delayed(const Duration(seconds: 1));

    final cacheService = context.read<CacheService>();
    final token = await cacheService.readToken();

    if (!mounted) return;

    if (token == null) {
      context.go(RouteName.login);
    } else {
      context.go(RouteName.home);
    }
  }
}
