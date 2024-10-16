import 'package:flutter/material.dart';
import 'package:fsui/screens/auth_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                BuildPage(
                    jsonPath:
                        'https://lottie.host/264d05ad-e788-4b70-aa39-b2a038fd0737/PqFZaU5km3.json',
                    text:
                        'Embrace Our Warm Welcome!\n\nIt\'s okay to feel here. You\'re not alone. Let\'s navigate anxiety and depression together.',
                    isLastScreen: false),
                BuildPage(
                    jsonPath:
                        'https://lottie.host/1e8bac7a-0070-4007-b3c7-c6163dd5b3a2/gPEg7RqHdI.json',
                    text:
                        'Begin Your Healing Journey!\n\nEngage, share, and heal. Private, one-to-one talks await at the end of each conversation.',
                    isLastScreen: false),
                BuildPage(
                    jsonPath:
                        'https://lottie.host/1e8bac7a-0070-4007-b3c7-c6163dd5b3a2/gPEg7RqHdI.json',
                    text:
                        'Your Privacy Matters\n\nShare details for personalized support and guidance on your healing journey.',
                    isLastScreen: true),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: const WormEffect(
              activeDotColor: Colors.black,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class BuildPage extends StatelessWidget {
  const BuildPage(
      {super.key,
      required this.jsonPath,
      required this.text,
      required this.isLastScreen});

  final String jsonPath;
  final String text;
  final bool isLastScreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.network(
                jsonPath,
                height: 300,
              ),
              const SizedBox(height: 40),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              if (isLastScreen)
                GestureDetector(
                  onTap: () {
                    Get.to(const AuthScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 222, 222, 222),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Text(
                      'Get Started!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
