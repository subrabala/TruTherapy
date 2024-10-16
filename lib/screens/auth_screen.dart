import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/bottom_navbar_screens/intro_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String errText = "";

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLogin = false;
  String? errorMsg;

  InputDecoration buildInputDecoration(
      String labelText, IconData prefixIcon, String? errorMsg) {
    return InputDecoration(
      hintText: labelText,
      hintStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
      prefixIcon: Icon(prefixIcon,
          color: const Color.fromARGB(255, 90, 156, 130), size: 18.0),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromARGB(255, 90, 156, 130),
            strokeAlign: BorderSide.strokeAlignCenter),
      ),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 90, 156, 130))),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
      errorText: errorMsg,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            height: null,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo_bg.png'), fit: BoxFit.cover),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            color: AppColors.light100,
            padding: const EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => IntroScreen());
                      // _googleSignInAndSendToken();
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
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                     
                      elevation:
                          MaterialStateProperty.all<double>(0), 
                      shadowColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 195, 140, 140),
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255),
                      ),
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
      ]),
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

      if (idToken != null) {
        final response = await http.post(
          Uri.parse('https://api.com/auth'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'session': idToken,
          }),
        );

        if (response.statusCode == 200) {
          Get.to(() => IntroScreen());
        } else {
          print(
              'Failed to send token to backend. Status code: ${response.statusCode}');
        }
      } else {
        print('Failed to retrieve ID token.');
      }
    } catch (error) {
      print('Error during Google sign-in: $error');
    }
  }
}
