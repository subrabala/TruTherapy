import 'package:flutter/material.dart';

class AppColors {
  static const Color dark800 = Color(0xFF0F273C); // dark800
  static const Color light100 = Color(0xFFDBF2F7); // light100
  static const Color mid = Color(0xFF1E7083); // mid
  static const Color lightYellow = Color(0xFFFCEFB4); // light yellow
  static const Color fsuiBlue = Color(0xFF08a8bd); // blue
}

extension PastelColors on Colors {
  static const Color seaBlue = Color.fromARGB(255, 178, 217, 241);
  static const Color seaBlueDark = Color.fromARGB(255, 90, 173, 221);

  static const Color pastelPink = Color(0xFFF9CCE4);
  static const Color pastelPinkDark = Color.fromARGB(255, 214, 115, 168);

  static const Color deepSeaBlue = Color(0xFFDCCCE7);
  static const Color deepSeaBlueDark = Color.fromARGB(255, 156, 97, 195);

  static const Color skyBlue = Color(0xFFBCE6FF);
  static const Color skyBlueDark = Color.fromARGB(255, 53, 124, 164);
}

String s3_cdn = 'https://d1pt64zek14ka0.cloudfront.net';

String backendUrl = 'https://backend.fsui.org/api/v1';
