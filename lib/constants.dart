import 'package:flutter/material.dart';

class AppColors {
  static const Color dark800 = Color(0xFF0F273C); // dark800
  static const Color light100 = Color(0xFFDBF2F7); // light100
  static const Color mid = Color(0xFF1E7083); // mid
  static const Color lightYellow = Color(0xFFFCEFB4); // light yellow
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



String backendUrl = 'https://backend.fsui.org/api/v1';

const jsonData = [
  {
    "imageUrl":
        "assets/dummy/yoga1.jpeg",
    "title": "How to Stay Positive",
    "subtitle": "Tips and tricks for a positive mindset."
  },
  {
    "imageUrl":
        "assets/dummy/yoga2.jpeg",
    "title": "The Benefits of Meditation",
    "subtitle": "Why you should start meditating today."
  },
  {
    "imageUrl":
        "assets/dummy/yoga3.jpeg",
    "title": "Healthy Eating Habits",
    "subtitle": "Simple changes for a healthier diet."
  },
  {
    "imageUrl":
        "assets/dummy/yoga4.jpeg",
    "title": "Exercise for Mental Health",
    "subtitle": "How exercise can improve your mood."
  },
  {
    "imageUrl":
        "assets/dummy/yoga1.jpeg",
    "title": "Finding Your Passion",
    "subtitle": "Discover what makes you happy."
  },
  {
    "imageUrl":
        "assets/dummy/yoga2.jpeg",
    "title": "Connecting with Nature",
    "subtitle": "The importance of outdoor activities."
  }
];
