import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsui/screens/onboarding_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(OnboardingScreen());
    });

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(
        'assets/splash.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}
