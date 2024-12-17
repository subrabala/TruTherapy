import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/therapist_screens/intro_screen.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart' as user;
import 'package:fsui/screens/user_screens/user_details_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.email'
    ],
  );

  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.light100,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/fsui.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "FSUI Sea Call",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
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
                decoration: const BoxDecoration(
                  color: Color(0xFF00334E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   const SizedBox(
                      height: 60,
                      
                    ),
                    Text(
                      "Let's Begin",
                      style: GoogleFonts.poppins(
                          fontSize: 28, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 42),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _googleSignInAndSendToken();
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.to(IntroScreen());
                        },
                        icon: Image.asset(
                          'assets/logo_google.png',
                          width: 25,
                          height: 25,
                        ),
                        label: const Text(
                          'Sign in as Therapist',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _googleSignInAndSendToken() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      String? idToken = googleAuth.idToken;

      Get.to(() => user.IntroScreen());

      // Get.to(() => UserDetailsScreen());
      if (idToken != null) {
        final response = await http.post(
          Uri.parse('$backendUrl/auth/app/jwt/user'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: jsonEncode({
            'session': idToken,
          }),
        );
        print(response.toString());

        if (response.statusCode == 200) {
          final jwt = jsonDecode(response.body)['jwt'];
          await setJwt(jwt);
          Get.to(()=> UserDetailsScreen());
        } else {
          print(
              'Failed to send token to backend. Status code: ${response.statusCode}');

        }
      } else {
        print('Failed to retrieve ID token.');
      }
    } catch (error) {
      print('Error Google sign-in: $error');
    }
  }
}



