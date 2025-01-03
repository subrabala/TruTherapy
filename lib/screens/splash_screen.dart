import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fsui/screens/auth_screen.dart';
import 'package:fsui/screens/therapist_screens/intro_screen.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart' as user;
import 'package:fsui/screens/onboarding_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      bool isFirstRun = await checkIfFirstRun();
      bool isLoggedInStatus =  isLoggedIn();
      String? scope =  getScope();

      if (isFirstRun) {
        Get.to(const OnboardingScreen());
      } else if (isLoggedInStatus) {
        if (scope == 'user') {
          Get.to(const user.IntroScreen());
        } else if (scope == 'therapist') {
          Get.to(const IntroScreen());
        } else {
          Get.to(AuthScreen());
        }
      } else {
        Get.to(AuthScreen());
      }
    });

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(
        'assets/fsui_splash.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}
