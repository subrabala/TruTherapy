import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsui/screens/auth_screen.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart';
import 'package:fsui/screens/onboarding_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      bool isFirstRun = await checkIfFirstRun();
      bool isLoggedIn = checkIfLoggedIn();

      if (isFirstRun) {
        Get.to(const OnboardingScreen());
      } else if (isLoggedIn) {
        Get.to(const IntroScreen());
      } else {
        Get.to(const AuthScreen());
      }
    });

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(
        'assets/splash.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}
