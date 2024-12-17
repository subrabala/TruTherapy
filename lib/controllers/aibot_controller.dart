import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

class AIBotController extends GetxController {
  final List<Map<String, String>> chatHistory = <Map<String, String>>[].obs;
  final List<String> responses = [
    "Hello! How can I help you today?",
    "I'm here to assist you with any queries.",
    "That's an interesting question!",
    "Let me think about that...",
    "Can you elaborate on that?"
  ];

  final RxBool isTyping = false.obs;

  void handleQuery(String query) {
    if (query.isEmpty) return;

    chatHistory.add({'user': query});
    _simulateTyping(query);
  }

  void _simulateTyping(String query) async {
    isTyping.value = true;
    final String response = _getRandomResponse();
    chatHistory.add({'bot': ''}); 
    int index = chatHistory.length - 1;

    for (int i = 1; i <= response.length; i++) {
      await Future.delayed(Duration(milliseconds: 50)); 
      chatHistory[index] = {'bot': response.substring(0, i)};
    }

    isTyping.value = false;
  }

  String _getRandomResponse() {
    final random = Random();
    return responses[random.nextInt(responses.length)];
  }

  List<Map<String, dynamic>> getChatMetadata() {
  return [
    {
      'id': '1',
      'heading': 'Chat with Support Bot for salary',
      'date': '01 Dec', // Changed date format
      'lastMessage': 'can you help me with my salary query?'
    },
    {
      'id': '2',
      'heading': 'I\'ve been feeling low lately',
      'date': '02 Dec', // Changed date format
      'lastMessage': "I'm not sure what's wrong with me"
    },
    {
      'id': '3',
      'heading': 'General Inquiry about the Chatbot\'s capabilities',
      'date': '03 Dec', // Changed date format
      'lastMessage': 'What can you do?'
    }
  ];
}

}
