import 'package:flutter/material.dart';
import 'package:fsui/constants.dart'; // Ensure this is your path for constants

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.dark800,
                      AppColors.light100,
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Here\'s what we have lined up for you today:',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: const Text('Chat Now'),
                        leading: const Icon(Icons.chat),
                        onTap: () {
                          // Handle chat action
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('Schedule a Call'),
                        leading: const Icon(Icons.schedule),
                        onTap: () {
                          // Handle schedule call action
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('View Notifications'),
                        leading: const Icon(Icons.notifications),
                        onTap: () {
                          // Handle view notifications action
                        },
                      ),
                    ),
                    // Add more ListTile items as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
