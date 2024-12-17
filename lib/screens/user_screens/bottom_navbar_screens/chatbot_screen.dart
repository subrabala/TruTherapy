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
        // Calculate total items for questions and answers
        final totalItems = controller.questions.length + controller.selectedAnswers.length + controller.answers.length;

        return ListView.builder(
          itemCount: totalItems,
          itemBuilder: (context, index) {
            // Determine if the current index is for a question or an answer
            bool isQuestion = index < controller.questions.length + controller.selectedAnswers.length;

            if (isQuestion) {
              // Display question
              int questionIndex = index ~/ 2; // Adjusted to match your questions
              if (index.isEven) { // Even index for questions
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: AppColors.light100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      controller.questions[questionIndex],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              } else {
                // Display answer
                int answerIndex = questionIndex; // Corresponding answer index
                if (answerIndex < controller.selectedAnswers.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.lightYellow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          controller.selectedAnswers[answerIndex],
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  );
                }
              }
            } else {
              // Calculate index for answer options
              int answerOptionIndex = index - (controller.questions.length + controller.selectedAnswers.length);
              if (answerOptionIndex < controller.answers.length) {
                final answer = controller.answers[answerOptionIndex];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.selectAnswer(answer['id']!);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 251, 244, 215),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              answer['text']!,
                              style: TextStyle(
                                color: AppColors.dark800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }

            return Container(); // Default return if nothing is matched
          },
        );
      }),
    );
  }
}
