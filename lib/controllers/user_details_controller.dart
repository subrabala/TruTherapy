import 'package:flutter/material.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:fsui/models.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart';
import 'package:lottie/lottie.dart';

class UserDetailsController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final emergencyContactNameController = TextEditingController();
  final seaBookNumberController = TextEditingController();

  final selectedGender = Rx<String?>(null);

  void submitDetails() {
    final userDetails = UserDetails(
      name: nameController.text,
      age: ageController.text,
      contactNumber: contactNumberController.text,
      emergencyContactNumber: emergencyContactController.text,
      seaBookNumber: seaBookNumberController.text,
      gender: selectedGender.value,
    );

    validate();
  }

  void validate() {
    String name = nameController.text;
    String age = ageController.text;
    String contactNumber = contactNumberController.text;
    String emergencyContact = emergencyContactController.text;
    String seaBookNumber = seaBookNumberController.text;

    if (name.isEmpty ||
        age.isEmpty ||
        contactNumber.isEmpty ||
        emergencyContact.isEmpty ||
        seaBookNumber.isEmpty ||
        selectedGender.value == null) {
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
      Get.offAll(() => IntroScreen());
    });
  }
}
