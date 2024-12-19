import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/auth_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
      backgroundColor: AppColors.light100,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                BuildPage(
                  jsonPath: 'assets/onboard1.jpg',
                  heading: 'Embrace Our Warm Welcome!',
                  subheading: 'It\'s okay to feel here. You\'re not alone. Let\'s navigate anxiety and depression together.',
                  isLastScreen: false,
                ),
                BuildPage(
                  jsonPath: 'assets/onboard2.png',
                  heading: 'Begin Your Healing Journey!',
                  subheading: 'Engage, share, and heal. Private, one-to-one talks await at the end of each conversation.',
                  isLastScreen: false,
                ),
                BuildPage(
                  jsonPath: 'assets/onboard3.png',
                  heading: 'Your Privacy Matters',
                  subheading: 'Share details for personalized support and guidance on your healing journey.',
                  isLastScreen: true,
                ),
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
  const BuildPage({
    super.key,
    required this.jsonPath,
    required this.heading,  
    required this.subheading, 
    required this.isLastScreen,
  });

  final String jsonPath;
  final String heading;  
  final String subheading;  
  final bool isLastScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.light100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (jsonPath.endsWith('.json'))
            Lottie.network(
              jsonPath,
              height: MediaQuery.of(context).size.height * 0.6, 
              fit: BoxFit.cover,
            )
          else
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                height: MediaQuery.of(context).size.height * 0.6,
                jsonPath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  heading,  
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  subheading, 
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.normal, 
                  ),
                ),
                const SizedBox(height: 40),
                if (isLastScreen)
                  GestureDetector(
                    onTap: () {
                      Get.to(const AuthScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
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
        ],
      ),
    );
  }
}

