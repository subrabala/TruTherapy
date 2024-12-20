import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fsui/widgets/gender_card.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/screens/user_screens/intro_screen.dart';
import 'package:fsui/controllers/user_details_controller.dart';

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
                          GenderCard(
                            icon: Icons.male,
                            label: "Male",
                            color: PastelColors.seaBlue,
                            darkColor: PastelColors.seaBlueDark,
                            isSelected:
                                controller.selectedGender.value == "Male",
                            onTap: () =>
                                controller.selectedGender.value = "Male",
                          ),
                          GenderCard(
                            icon: Icons.female,
                            label: "Female",
                            color: PastelColors.pastelPink,
                            darkColor: PastelColors.pastelPinkDark,
                            isSelected:
                                controller.selectedGender.value == "Female",
                            onTap: () =>
                                controller.selectedGender.value = "Female",
                          ),
                          GenderCard(
                            icon: Icons.transgender,
                            label: "Other",
                            color: PastelColors.deepSeaBlue,
                            darkColor: PastelColors.deepSeaBlueDark,
                            isSelected:
                                controller.selectedGender.value == "Other",
                            onTap: () =>
                                controller.selectedGender.value = "Other",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    buildTextFormField(
                      isAlphaNumeric: true,
                      controller: controller.seaBookNumberController,
                      label: 'Sea Book Number',
                      hintText: 'Ex. SD1343',
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
    bool isAlphaNumeric = false,
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
}
