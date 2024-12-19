import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
  return false;
}

Future<void> openYouTubeInPiPMode(String youtubeUrl) async {
  final Uri url = Uri.parse(youtubeUrl);

  print('Opening $url in PiP mode');

  if (await canLaunchUrl(url)) {
    try {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      print("Error while launching URL: $e");
      throw 'Could not open the URL: $e';
    }
  } else {
    print("Cannot launch the URL: $youtubeUrl");
    throw 'Could not open the URL.';
  }
}
