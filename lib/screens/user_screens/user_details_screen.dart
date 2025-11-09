import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:fsui/widgets/gender_card.dart';
import 'package:fsui/constants.dart';
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
                padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextFormField(
                      controller: controller.seaBookNumberController,
                      label: 'Sea Book Number',
                      hintText: 'Ex. A123456',
                      icon: Icons.book_outlined,
                      pastelColor: PastelColors.seaBlue,
                      isOptional: true
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (selectedDate != null) {
                                controller.selectedDob.value =
                                    selectedDate.toUtc();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: PastelColors.deepSeaBlue),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Obx(() {
                                final dob = controller.selectedDob.value;
                                final dateText = dob != null
                                    ? "${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}"
                                    : 'YYYY-MM-DD';

                                return TextFormField(
                                  controller:
                                      TextEditingController(text: dateText),
                                  decoration: const InputDecoration(
                                    labelText: 'Date of Birth',
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    hintText: 'Select your date of birth',
                                    icon: Icon(Icons.calendar_today,
                                        color: PastelColors.deepSeaBlue),
                                    border: InputBorder.none,
                                  ),
                                  enabled: false,
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
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
                    const SizedBox(height: 10.0),
                    
                    // User Type Dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "User Type",
                          style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          decoration: BoxDecoration(
                            color: PastelColors.seaBlue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: PastelColors.seaBlue,
                              width: 1.0,
                            ),
                          ),
                          child: Obx(() => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedUserType.value,
                              hint: const Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  'Select User Type',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: PastelColors.seaBlue,
                              ),
                              items: controller.userTypes.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text(
                                      type,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                controller.selectedUserType.value = newValue;
                              },
                            ),
                          )),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 10.0),

                    // GENDER
                    const Text(
                      "Gender",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6.0),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GenderCard(
                              icon: Icons.male,
                              label: "Male",
                              color: PastelColors.seaBlue,
                              darkColor: PastelColors.seaBlueDark,
                              isSelected:
                                  controller.selectedGender.value == "male",
                              onTap: () =>
                                  controller.selectedGender.value = "male",
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: GenderCard(
                              icon: Icons.female,
                              label: "Female",
                              color: PastelColors.pastelPink,
                              darkColor: PastelColors.pastelPinkDark,
                              isSelected:
                                  controller.selectedGender.value == "female",
                              onTap: () =>
                                  controller.selectedGender.value = "female",
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: GenderCard(
                              icon: Icons.transgender,
                              label: "Other",
                              color: PastelColors.deepSeaBlue,
                              darkColor: PastelColors.deepSeaBlueDark,
                              isSelected:
                                  controller.selectedGender.value == "other",
                              onTap: () =>
                                  controller.selectedGender.value = "other",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10.0),
                    buildCountryPicker(
                      label: "Nationality",
                      value: controller.selectedNationality,
                      icon: Icons.flag,
                      pastelColor: PastelColors.skyBlue,
                    ),
                    const SizedBox(height: 10.0),
                    buildTextFormField(
                      controller: controller.passportNumberController,
                      label: 'Passport Number',
                      hintText: 'Ex. A12345678',
                      icon: Icons.travel_explore,
                      pastelColor: PastelColors.seaBlue,
                      isOptional: true
                    ),
                    const SizedBox(height: 16.0),
                    buildCountryPicker(
                      label: "Place of Issue",
                      value: controller.placeOfIssue,
                      icon: Icons.location_on,
                      pastelColor: PastelColors.deepSeaBlue,
                    ),
                    const SizedBox(height: 16.0),
                    buildTextFormField(
                      controller: controller.emergencyContactNameController,
                      label: 'Emergency Contact Name',
                      hintText: 'Ex. Jane Doe',
                      icon: Icons.person,
                      pastelColor: PastelColors.pastelPink,
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
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildCountryPicker({
    required String label,
    required Rx<String?> value,
    required IconData icon,
    required Color pastelColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6.0),
          Obx(
            () => InkWell(
              onTap: () {
                showCountryPicker(
                  context: Get.context!,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    value.value = country.name;
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: pastelColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: pastelColor, width: 1.0),
                ),
                child: Row(
                  children: [
                    Icon(icon, color: pastelColor, size: 20),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        (value.value ?? '').isEmpty
                            ? 'Select $label'
                            : value.value!,
                        style: TextStyle(
                          fontSize: 13,
                          color: (value.value ?? '').isEmpty
                              ? Colors.grey
                              : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
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
    bool isOptional = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 13),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters:
            isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          labelText: isOptional ? '$label (Optional)' : label,
          labelStyle: const TextStyle(fontSize: 13),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12),
          prefixIcon: Icon(icon, color: pastelColor, size: 20),
          filled: true,
          fillColor: pastelColor.withOpacity(0.2),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isOptional ? pastelColor.withOpacity(0.5) : pastelColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isOptional ? pastelColor.withOpacity(0.7) : pastelColor,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
