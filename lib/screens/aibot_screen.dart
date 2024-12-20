import 'package:flutter/material.dart';
import 'package:fsui/constants.dart';
import 'package:fsui/controllers/aibot_controller.dart';
import 'package:get/get.dart';

class AIBotScreen extends StatelessWidget {
  final AIBotController controller = Get.put(AIBotController());
  final TextEditingController queryController = TextEditingController();
  final String chatId;

  AIBotScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Aqua Bot",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mid,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.chatHistory.length,
                  itemBuilder: (context, index) {
                    final message = controller.chatHistory[index];
                    final isUser = message.containsKey('user');
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8.0,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue[100] : Colors.green[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          isUser ? message['user']! : message['bot']!,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            Obx(() {
              return controller.isTyping.value
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Bot is typing...",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    )
                  : const SizedBox.shrink();
            }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                        hintText: "Enter your message...",
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide:
                              const BorderSide(color: PastelColors.skyBlueDark),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: PastelColors.skyBlueDark,
                    ),
                    onPressed: () {
                      controller.handleQuery(queryController.text.trim());
                      queryController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
