import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

Future<void> setJwt(String jwt, {bool isTemp = false}) async {
  final prefs = await SharedPreferences.getInstance();
  if (isTemp) {
    await prefs.setString('jwtTemp', jwt); 
  } else {
    await prefs.setString('jwt', jwt); 
  }
}


Future<String?> getJwt({bool isTemp = false}) async {
  final prefs = await SharedPreferences.getInstance();
  if (isTemp) {
    return prefs.getString('jwtTemp'); 
  } else {
    return prefs.getString('jwt');
  }
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

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('jwt');

  if (jwt != null && jwt.isNotEmpty) {
    return true;
  }
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

String convertToReadableDate(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);
  
  String formattedDate = DateFormat('dd-MM-yyyy, hh:mm').format(dateTime);
  
  return formattedDate;
}
