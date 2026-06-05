import 'dart:convert';
import 'dart:io';

import 'package:fsui/screens/auth_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

/// Checks if a JWT token is expired
bool isJwtExpired(String token) {
  try {
    final parts = token.split('.');
    if (parts.length != 3) return true;
    final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    final exp = payload['exp'];
    if (exp == null) return true;
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expiryDate);
  } catch (_) {
    return true;
  }
}

/// Checks JWT and redirects to AuthScreen if expired
void checkJwtAndRedirectIfExpired() {
  String? jwt = getJwt();
  if (jwt == null || isJwtExpired(jwt)) {
    Get.offAll(() => AuthScreen());
  }
}

/// Checks therapist JWT and redirects to AuthScreen if expired
void checkTherapistJwtAndRedirectIfExpired() {
  String? jwt = getTherapistJwt();
  if (jwt == null || isJwtExpired(jwt)) {
    Get.offAll(() => AuthScreen());
  }
}

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  SharedPreferences? _preferences;

  SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_preferences == null) {
      throw Exception("SharedPrefs not initialized. Call init() first.");
    }
    return _preferences!;
  }
}

Future<void> setJwt(String jwt, {bool isTemp = false}) async {
  final prefs = SharedPrefs().prefs;
  if (isTemp) {
    await prefs.setString('jwtTemp', jwt);
  } else {
    await prefs.setString('jwt', jwt);
    await prefs.setString('scope', "user");
  }
}

String? getJwt({bool isTemp = false}) {
  final prefs = SharedPrefs().prefs;
  if (isTemp) {
    return prefs.getString('jwtTemp');
  }
  final scope = getScope();
  if (scope == 'user') {
    return prefs.getString('jwt');
  } else if (scope == 'therapist') {
    return prefs.getString('jwtTherapist');
  }
  return null;
}

Future<void> setTherapistJwt(String jwt) async {
  final prefs = SharedPrefs().prefs;
  await prefs.setString('jwtTherapist', jwt);
  await prefs.setString('scope', 'therapist');
}

String? getTherapistJwt() {
  final prefs = SharedPrefs().prefs;
  return prefs.getString('jwtTherapist');
}

Future<bool> checkIfFirstRun() async {
  final prefs = SharedPrefs().prefs;
  bool? isFirstRun = prefs.getBool('isFirstRun');
  if (isFirstRun == null) {
    await prefs.setBool('isFirstRun', false);
    return true;
  }
  return false;
}

bool isLoggedIn() {
  final prefs = SharedPrefs().prefs;
  if (getScope() == 'user') {
    final jwt = prefs.getString('jwt');
    return jwt != null && jwt.isNotEmpty;
  } else if (getScope() == 'therapist') {
    final jwt = prefs.getString('jwtTherapist');
    return jwt != null && jwt.isNotEmpty;
  } else {
    return false;
  }
}

String convertToReadableDateAndTime(String timestamp) {
  DateTime dateTime =
      DateTime.parse(timestamp).add(const Duration(hours: 5, minutes: 30));
  return DateFormat('dd-MM-yyyy, hh:mm').format(dateTime);
}

String convertToReadableDate(String timestamp) {
  DateTime dateTime =
      DateTime.parse(timestamp).add(const Duration(hours: 5, minutes: 30));
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

String? getScope() {
  final prefs = SharedPrefs().prefs;
  return prefs.getString('scope');
}

