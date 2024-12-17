import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart';
class UserDetailsController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emergencyContactController = TextEditingController();
  final emergencyContactNameController = TextEditingController();
  final seaBookNumberController = TextEditingController();

  final selectedGender = Rx<String?>(null);

  void submitDetails() {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        contactNumberController.text.isEmpty ||
        emergencyContactController.text.isEmpty ||
        seaBookNumberController.text.isEmpty ||
        selectedGender.value == null) {
      Get.snackbar(
        "Missing Fields",
        "Please fill all fields before submitting.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 255, 217, 217),
        colorText: const Color.fromARGB(255, 255, 116, 116),
        borderRadius: 8.0,
        margin: const EdgeInsets.all(8.0),
      );
      return;
    }

    final userDetails = UserDetails(
      name: nameController.text,
      age: ageController.text,
      contactNumber: contactNumberController.text,
      emergencyContactNumber: emergencyContactController.text,
      seaBookNumber: seaBookNumberController.text,
      gender: selectedGender.value,
    );

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
                  'assets/lottie/success.json', 
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

class UserDetailsScreen extends StatelessWidget {
  final UserDetailsController controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tell us more about you!'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFormField(
                      controller: controller.nameController,
                      label: 'Name',
                      hintText: 'Ex. John Doe',
                      icon: Icons.person,
                      pastelColor: PastelColors.seaBlue,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: buildTextFormField(
                            isNumeric: true,
                            controller: controller.ageController,
                            label: 'Age',
                            hintText: 'Ex. 35',
                            icon: Icons.calendar_today,
                            pastelColor: PastelColors.deepSeaBlue,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          flex: 2,
                          child: buildTextFormField(
                            isNumeric: true,
                            controller: controller.contactNumberController,
                            label: 'Contact',
                            hintText: 'Ex. 9912345678',
                            icon: Icons.phone,
                            pastelColor: PastelColors.seaBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Gender",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildGenderSelectionCard(
                            icon: Icons.male,
                            label: "Male",
                            color: PastelColors.seaBlue,
                            darkColor: PastelColors.seaBlueDark,
                            isSelected: controller.selectedGender.value == "Male",
                            onTap: () => controller.selectedGender.value = "Male",
                          ),
                          buildGenderSelectionCard(
                            icon: Icons.female,
                            label: "Female",
                            color: PastelColors.pastelPink,
                            darkColor: PastelColors.pastelPinkDark,
                            isSelected: controller.selectedGender.value == "Female",
                            onTap: () =>
                                controller.selectedGender.value = "Female",
                          ),
                          buildGenderSelectionCard(
                            icon: Icons.transgender,
                            label: "Other",
                            color: PastelColors.deepSeaBlue,
                            darkColor: PastelColors.deepSeaBlueDark,
                            isSelected: controller.selectedGender.value == "Other",
                            onTap: () =>
                                controller.selectedGender.value = "Other",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    buildTextFormField(
                      isNumeric: true,
                      controller: controller.seaBookNumberController,
                      label: 'Sea Book Number',
                      hintText: 'Ex. 1234',
                      icon: Icons.book,
                      pastelColor: PastelColors.seaBlue,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextFormField(
                      isNumeric: true,
                      controller: controller.emergencyContactController,
                      label: 'Emergency Contact Number',
                      hintText: 'Ex. 123456789',
                      icon: Icons.phone_android,
                      pastelColor: PastelColors.deepSeaBlue,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextFormField(
                      controller: controller.emergencyContactNameController,
                      label: 'Emergency Contact Name',
                      hintText: 'Ex. Jane Doe',
                      icon: Icons.person,
                      pastelColor: PastelColors.deepSeaBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.submitDetails();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mid,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    required Color pastelColor,
    bool isNumeric = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters:
            isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon, color: pastelColor),
          filled: true,
          fillColor: pastelColor.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pastelColor),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pastelColor, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget buildGenderSelectionCard({
    required IconData icon,
    required String label,
    required Color darkColor,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? darkColor.withOpacity(0.8) : color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: isSelected ?  Colors.white  : darkColor),
            const SizedBox(height: 8.0),
            Text(
              label,
              style:  TextStyle(color: isSelected ?   Colors.white : darkColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
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


class UserDetails {
  String? age;
  String? gender;
  String? seaBookNumber;
  String? contactNumber;
  String? emergencyContactNumber;
  String? name;

  UserDetails({
    this.age,
    this.gender,
    this.seaBookNumber,
    this.contactNumber,
    this.emergencyContactNumber,
    this.name,
  });
}