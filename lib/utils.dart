import 'package:shared_preferences/shared_preferences.dart';

Future<void> setJwt(String jwt) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', jwt);
}

Future<String?> getJwt() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt');
}

Future<bool> checkIfFirstRun() async {
  final prefs = await SharedPreferences.getInstance();
  bool? isFirstRun = prefs.getBool('isFirstRun');
  if (isFirstRun == null) {
    await prefs.setBool('isFirstRun', false);
    return true;
  }
  return false;
}

bool checkIfLoggedIn() {
  return true;
}
