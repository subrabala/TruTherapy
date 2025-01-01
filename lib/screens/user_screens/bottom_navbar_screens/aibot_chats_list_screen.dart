import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/aibot_controller.dart';
import 'package:fsui/screens/aibot_screen.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';

class AIBotChatsListScreen extends StatelessWidget {
  final AIBotController controller = Get.put(AIBotController());

  AIBotChatsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getChatsList();
    });
    return WillPopScope(
      onWillPop: () async {
        Get.delete<AIBotController>();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Chat History',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue.shade900),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: PastelColors.skyBlueDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextButton(
                  onPressed: () {
                    controller.currentSessionId = null;
                    controller.chatLogsForSession.clear();
                    controller.chatHistory.clear();
                    Get.to(() => AIBotScreen());
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        "New Chat",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: const Text(
                  'Recents',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getChatsList();
                  },
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: controller.chatMetadata.length,
                      itemBuilder: (context, index) {
                        final chat = controller.chatMetadata[index];
                        return GestureDetector(
                          onTap: () async {
                            await controller
                                .getChatsForSession(chat['session_id']);
                            Get.to(() => AIBotScreen());
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 250, 228),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat['response'].length > 30
                                      ? '${chat['response'].substring(0, 30)}...'
                                      : chat['response'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  convertToReadableDateAndTime(
                                      chat['asked_at']),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
