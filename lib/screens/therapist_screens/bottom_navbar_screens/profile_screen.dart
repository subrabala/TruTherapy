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
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: controller.profileDetails.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          controller.profileDetails['profile_picture'] !=
                                      null &&
                                  controller.profileDetails['profile_picture']!
                                      .isNotEmpty
                              ? NetworkImage(
                                  controller.profileDetails['profile_picture']!)
                              : const AssetImage('assets/mental1.jpg')
                                  as ImageProvider,
                    ),
                    const SizedBox(height: 20),

                    // Name
                    Text(
                      controller.profileDetails['name'] ?? "",
                      style: const TextStyle(
                        fontSize: 20,
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
                    const SizedBox(height: 30),

                    // Contact Details
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: PastelColors.skyBlue.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Contact Number
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${controller.profileDetails['phone_number']?.substring(4) ?? ""}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Email
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.email_outlined,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${controller.profileDetails['email'] ?? ""}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                              ],
                            ),
                          ),
                        ]),

                    const SizedBox(height: 20),
                  ],
                )
              : Center(child: Text('Failed to retrieve user information')),
        ),
      ),
    );
  }
}
