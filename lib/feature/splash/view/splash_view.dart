import 'package:Shartflix/feature/splash/view/mixin/splash_view_mixin.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.images.sinFlixSplash.image(
          package: 'gen',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
