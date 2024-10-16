import 'package:flutter/material.dart';
import 'package:fsui/controllers/chatbot_controller.dart';
import 'package:get/get.dart';
import 'package:fsui/constants.dart'; // Ensure AppColors is imported

class ChatBotScreen extends StatelessWidget {
  final ChatBotController controller = Get.put(ChatBotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: AppColors.dark800,
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.selectedAnswers.length + 1 + controller.answers.length,
          itemBuilder: (context, index) {
            // Display question
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.light100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    controller.question.value,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }

            // Display selected answers
            if (index <= controller.selectedAnswers.length) {
              final answer = controller.selectedAnswers[index - 1];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.light100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    answer,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }

            // Display answer options
            final answer = controller.answers[index - controller.selectedAnswers.length - 1];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  controller.selectAnswer(answer['id']!);
                },
                child: Text(answer['text']!),
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.dark800,
                  backgroundColor: AppColors.light100,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
