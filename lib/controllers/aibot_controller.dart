import 'dart:async';
import 'dart:convert';
import 'package:fsui/constants.dart';
import 'package:fsui/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIBotController extends GetxController {
  final List<Map<String, String>> chatHistory = <Map<String, String>>[].obs;
  final List<Map<String, dynamic>> chatMetadata = <Map<String, dynamic>>[];
  final RxBool isTyping = false.obs;

  Future<void> handleQuery(String query) async {
    if (query.isEmpty) return;

    chatHistory.add({'user': query});
    isTyping.value = true;

    try {
      final jwt = await getJwt();
      final response = await http.post(
        Uri.parse('$backendUrl/chat/response'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${jwt}',
        },
        body: jsonEncode({
          // "session_id": [null],
          "query": query
        }),
      );

      if (response.statusCode == 200) {
        final String botResponse = response.body;

        await _simulateTyping(botResponse);
      } else {
        chatHistory.add({'bot': 'Error: ${response.statusCode}'});
      }
    } catch (e) {
      chatHistory.add({'bot': 'Error: Unable to connect to server'});
    } finally {
      isTyping.value = false;
    }
  }

  Future<void> _simulateTyping(String response) async {
    final Map<String, String> botResponse = {'bot': ''};
    chatHistory.add(botResponse);

    for (int i = 1; i <= response.length; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      botResponse['bot'] = response.substring(0, i);
      chatHistory[chatHistory.length - 1] = botResponse;
    }
  }

  Future<void> getChatsList() async {
    try {
      final response = await http.get(
        Uri.parse('$backendUrl/chat/logs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${getJwt()}',
        },
      );

      if (response.statusCode == 200) {}
    } catch (e) {}
  }
}
