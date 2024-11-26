import 'package:flutter/material.dart';
import 'package:fsui/controllers/aibot_controller.dart';
import 'package:get/get.dart';

class AIBotScreen extends StatelessWidget {
  final AIBotController controller = Get.put(AIBotController());
  final TextEditingController queryController = TextEditingController();

  AIBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Buddy")),
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
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
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
                    child: Text("Bot is typing...", style: TextStyle(fontStyle: FontStyle.italic)),
                  )
                : const SizedBox.shrink();
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: queryController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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
    );
  }
}
