import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/user_screens/user_details_screen.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:fsui/models.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class UserDetailsController extends GetxController {
  final contactNumberController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final emergencyContactNameController = TextEditingController();
  final seaBookNumberController = TextEditingController();
  final passportNumberController = TextEditingController();
  var placeOfIssue = Rx<String?>(null);
  final selectedGender = Rx<String?>(null);
  final selectedNationality = Rx<String?>(null);
  final selectedLanguage = Rx<String?>(null);
  final selectedDob = Rx<DateTime?>(null);

  void submitDetails() {
    final userDetails = UserDetails(
      contactNumber: contactNumberController.text,
      emergencyContactNumber: emergencyContactController.text,
      emergencyContactName: emergencyContactNameController.text,
      seaBookNumber: seaBookNumberController.text,
      gender: selectedGender.value,
      dob: selectedDob.value?.toIso8601String(),
      nationality: selectedNationality.value,
      language: selectedLanguage.value,
      passportNumber: passportNumberController.text,
      placeOfIssue: placeOfIssue.value,
    );

    validate(userDetails);
  }

  void validate(UserDetails userDetails) {
    String contactNumber = userDetails.contactNumber ?? '';
    String emergencyContact = userDetails.emergencyContactNumber ?? '';
    String seaBookNumber = userDetails.seaBookNumber ?? '';
    DateTime? dob =
        userDetails.dob != null ? DateTime.parse(userDetails.dob!) : null;

    if (contactNumber.isEmpty ||
        emergencyContact.isEmpty ||
        seaBookNumber.isEmpty ||
        selectedGender.value == null ||
        selectedNationality.value == null ||
        selectedLanguage.value == null ||
        dob == null) {
      CommonSnackbar.show(
        text: "Missing Fields",
        subtext: "Please fill all fields before submitting.",
        color: "red",
      );
      return;
    }

    if (contactNumber.length != 10 ||
        !RegExp(r'^[0-9]+$').hasMatch(contactNumber)) {
      CommonSnackbar.show(
        text: "Invalid Phone Number",
        subtext: "Phone number must be exactly 10 digits.",
        color: "red",
      );
      return;
    }

    if (!RegExp(r'^[a-zA-Z]{2,3}[0-9]{4}$').hasMatch(seaBookNumber)) {
      CommonSnackbar.show(
        text: "Invalid Sea Book Number",
        subtext:
            "Sea Book number must start with 2 or 3 alphabets followed by 4 digits.",
        color: "red",
      );
      return;
    }

    if (emergencyContact.length != 10 ||
        !RegExp(r'^[0-9]+$').hasMatch(emergencyContact)) {
      CommonSnackbar.show(
        text: "Invalid Emergency Contact",
        subtext: "Emergency contact number must be exactly 10 digits.",
        color: "red",
      );
      return;
    }
    createUser(userDetails);
  }

  void createUser(UserDetails userDetails) async {
    try {
      final jwt = await getJwt(isTemp: true);
      final body = {
        "dob": userDetails.dob,
        "gender": userDetails.gender,
        "phone_number": userDetails.contactNumber,
        "nationality": userDetails.nationality,
        "language": userDetails.language,
        "nok_name": userDetails.emergencyContactName,
        "nok_phone_number": userDetails.emergencyContactNumber,
        "nok_relationship": "string",
        "passport_number": userDetails.passportNumber,
        "passport_place_of_issue": userDetails.placeOfIssue,
        "passport_expiry": "2024-12-22T12:59:10.769Z",
      };

      final response = await http.post(
        Uri.parse('$backendUrl/auth/create_user'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final jwt = jsonDecode(response.body)['access_token'];
        await setJwt(jwt);
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
          Get.offAll(() => IntroScreen());
        });
        Get.dialog(
          Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/success.json',
                      width: 100,
                      height: 100,
                      repeat: false,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Submitted Successfully!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          barrierDismissible: false,
        );
        Get.to(() => UserDetailsScreen());
      } else {
        CommonSnackbar.show(
            text: 'Failed to create user',
            subtext: 'Status code: ${response.statusCode}',
            color: "red");
      }
    } catch (error) {
      print('Error creating user: $error');
    }
  }
}
