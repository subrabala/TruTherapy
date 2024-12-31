import 'dart:async';
import 'dart:convert';
import 'package:fsui/constants.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AIBotController extends GetxController {
  final List<Map<String, String>> chatHistory = <Map<String, String>>[].obs;
  List<Map<String, dynamic>> chatMetadata = <Map<String, dynamic>>[];
  RxList<Map<String, dynamic>> chatLogsForSession = <Map<String, dynamic>>[].obs;

  final RxBool isTyping = false.obs;

  String? currentSessionId = null;

  void onInit() {
    getChatsList();
  }

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
          if (currentSessionId != null) 'session_id': currentSessionId,
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        final String botResponse = response.body;
        currentSessionId = response.headers['x-chat-session-id'];
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
      final jwt = await getJwt();

      final response = await http.get(
        Uri.parse('$backendUrl/chat/logs'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${jwt}',
        },
      );

      if (response.statusCode == 200) {
        chatMetadata =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
      }
    } catch (e) {}
  }

  Future<void> getChatsForSession(session_id) async {
    try {
      final jwt = await getJwt();

      final response = await http.get(
        Uri.parse('$backendUrl/chat/logs/$session_id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${jwt}',
        },
      );

      if (response.statusCode == 200) {
        currentSessionId = session_id;
        chatLogsForSession.value =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
      }
    } catch (e) {
      CommonSnackbar.show(color: "red", text: "Error while fetching data", subtext: e.toString());
    }
  }
}
