
import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatelessWidget {
AuthScreen({super.key});

final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: PastelColors.seaBlue.withOpacity(0.6),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/fsui_plain.png',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "FSUI Sea Call",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: AppColors.dark800),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        "Anchor your mind...",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            color: AppColors.dark800),
                      )
                    ],
                  ),
                ),
              ),

              // Bottom section
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(35.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        PastelColors.skyBlueDark,
                        PastelColors.skyBlueDark.withOpacity(0.6),
                        PastelColors.seaBlue,
                      ],
                      stops: [0.0, 0.6, 1.0],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Begin",
                        style: GoogleFonts.poppins(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 42),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.googleSignInAndSendToken();
                          },
                          icon: Image.asset(
                            'assets/logo_google.png',
                            width: 25,
                            height: 25,
                          ),
                          label: const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Color.fromARGB(255, 97, 97, 97),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(0),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.googleSignInAndSendTokenTherapist();
                          },
                          icon: Image.asset(
                            'assets/logo_google.png',
                            width: 25,
                            height: 25,
                          ),
                          label: Text(
                            'Sign in as Therapist',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.dark800),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(0),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 42),
                      Text("Don't have an account? We'll create one for you!",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
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
