import 'package:fsui/constants.dart';
import 'package:fsui/screens/user_screens/user_details_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fsui/utils.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart' as user;
import 'package:fsui/screens/therapist_screens/intro_screen.dart';

class AuthController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.email'
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
        final response = await http.post(
          Uri.parse('$backendUrl/auth/app/jwt/user'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie': 'session=$idToken',
          },
        );
        print(response.toString());

        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['access_token'] != null) {
            final jwt = jsonDecode(response.body)['access_token'];
            await setJwt(jwt);
            Get.to(() => user.IntroScreen());
          }
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

  Future<void> googleSignInAndSendTokenTherapist() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      String? idToken = googleAuth.idToken;

      if (idToken != null) {
        final response = await http.post(
          Uri.parse('$backendUrl/auth/app/jwt/therepist'),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Cookie': 'session=$idToken',
          },
        );
        print(response.toString());

        if (response.statusCode == 200) {
          if (jsonDecode(response.body)['access_token'] != null) {
            final jwt = jsonDecode(response.body)['access_token'];
            await setJwt(jwt);
            Get.to(() => UserDetailsScreen());
          }
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
