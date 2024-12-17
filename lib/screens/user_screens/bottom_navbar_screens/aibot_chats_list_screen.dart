import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/aibot_controller.dart';
import 'package:fsui/screens/aibot_screen.dart';
import 'package:get/get.dart';

class AIBotChatsListScreen extends StatelessWidget {
  final AIBotController controller = Get.put(AIBotController());

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chatMetadata =
        controller.getChatMetadata();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Your Chats',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue.shade900),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.dark800,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextButton.icon(
                onPressed: () {
                  Get.to(() => AIBotScreen(chatId: 'new'));
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: const Text(
                  "New Chat",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: AppColors.light100,
        child: ListView.builder(
          itemCount: chatMetadata.length,
          itemBuilder: (context, index) {
            final chat = chatMetadata[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => AIBotScreen(chatId: chat['id']));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat['heading'].length > 30
                          ? '${chat['heading'].substring(0, 30)}...'
                          : chat['heading'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          chat['date'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          chat['lastMessage'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
