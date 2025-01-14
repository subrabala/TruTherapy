import 'dart:io';

import 'package:fsui/constants.dart';
import 'package:fsui/controllers/user_details_controller.dart';
import 'package:fsui/screens/auth_screen.dart';
import 'package:fsui/screens/user_screens/user_details_screen.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fsui/utils.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart' as user;
import 'package:fsui/screens/therapist_screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile'
    ],
  );

  Future<void> googleSignInAndSendToken() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      String? idToken = googleAuth.idToken;

      if (idToken != null) {
        final response = await http.get(
          Uri.parse('$backendUrl/auth/app/jwt/user'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie': 'session=$idToken',
            'platform': Platform.isIOS ? 'ios' : 'web',
          },
        );

        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['access_token'] != null) {
            final jwt = jsonDecode(response.body)['access_token'];
            final scope = jsonDecode(response.body)['scopes'][0];
            if (scope != 'newuser') {
              await setJwt(jwt);
              Get.to(() => const user.IntroScreen());
            } else {
              await setJwt(isTemp: true, jwt);
              Get.to(() => UserDetailsScreen());
            }
          }
        } else {
          CommonSnackbar.show(
              text: 'Something went wrong',
              subtext: 'Error: ${response.statusCode}',
              color: "red");
        }
      } else {
        print('Failed to retrieve ID token.');
      }
    } catch (error) {
      print(error.toString());
      CommonSnackbar.show(
          text: 'Something went wrong',
          subtext: 'Error: ${error.toString()}',
          color: "red");
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse('$backendUrl/auth/logout'),
      headers: {'Authorization': 'Bearer ${getJwt()}'},
    );
    if (response.statusCode == 200) {
      await prefs.remove('jwt');
      Get.to(() => AuthScreen());
    }
  }

  Future<void> googleSignInAndSendTokenTherapist() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      String? idToken = googleAuth.idToken;

      if (idToken != null) {
        final response = await http.get(
          Uri.parse('$backendUrl/auth/app/jwt/therapist'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie': 'session=$idToken',
          },
        );

        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['access_token'] != null) {
            final jwt = jsonDecode(response.body)['access_token'];
            await setTherapistJwt(jwt);

            Get.to(() => const IntroScreen());
          }
        } else {
          CommonSnackbar.show(
              text: 'Something went wrong',
              subtext: 'Error: ${response.statusCode}',
              color: "red");
        }
      } else {
        print('Failed to retrieve ID token.');
      }
    } catch (error) {
      print('Error Google sign-in: $error');
    }
  }
}
