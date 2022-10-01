import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_editing_app/core/init/routes/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          'assets/lottie/lottie_camera.json',
          onLoaded: (p0) async {
            await Future.delayed(const Duration(seconds: 3));
            Navigator.popAndPushNamed(context, RouteEnums.main.name);
          },
        ),
      ),
    );
  }
}
