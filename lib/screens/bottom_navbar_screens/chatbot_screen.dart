import 'package:flutter/material.dart';
import 'package:fsui/controllers/chatbot_controller.dart';
import 'package:get/get.dart';

class ChatBotScreen extends StatelessWidget {
  final ChatBotController controller = Get.put(ChatBotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Column(
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  controller.question.value,
                  style: const TextStyle(fontSize: 18),
                ),
              )),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.answers.length,
                itemBuilder: (context, index) {
                  final answer = controller.answers[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.selectAnswer(answer['id']!);
                      },
                      child: Text(answer['text']!),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
