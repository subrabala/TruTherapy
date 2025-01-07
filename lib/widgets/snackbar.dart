import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackbar {
  static void show({
    required String text,
    required String subtext,
    required String color,
  }) {
    Get.snackbar(
      text,
      subtext,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color == "red"
          ? const Color.fromARGB(255, 255, 132, 132)
          : const Color.fromARGB(255, 117, 225, 173),
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(8.0),
      titleText: Text(
        text,
        style:   TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: color =='red' ? Colors.white : const Color.fromARGB(255, 7, 104, 10),
        ),
      ),
    );
  }
}
