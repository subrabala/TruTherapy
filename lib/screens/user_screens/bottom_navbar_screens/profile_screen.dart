import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/auth_controller.dart';
import 'package:fsui/controllers/user_details_controller.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.fetchProfileDetails();
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Your Profile',
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              if (value == 1) {
                Get.put(AuthController());
                Get.find<AuthController>().signOut();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      "Log Out",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/mental1.jpg'),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20),

            // Name
            Text(
              controller.profileDetails['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Age, Gender
            Text(
              "${convertToReadableDate(controller.profileDetails['dob'])} , " +
                  '${controller.profileDetails['gender']?[0].toUpperCase()}${controller.profileDetails['gender']?.substring(1) ?? ''}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Contact Number
            Text(
              'Contact: ${controller.profileDetails['phone_number']}',
              style: const TextStyle(
                fontSize: 16,
                color: PastelColors.deepSeaBlueDark,
              ),
            ),
            const SizedBox(height: 10),

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(85, 250, 188, 196),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Emergency Contact',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '👤     ${controller.profileDetails['nok_name']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '📞     ${controller.profileDetails['nok_phone_number']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '📘     ${controller.profileDetails['passport_number']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
