import 'dart:convert';

import 'package:fsui/constants.dart';
import 'package:fsui/utils.dart';
import 'package:fsui/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmergencyChatController extends GetxController {
  final RxList<Map<String, dynamic>> chatMessages =
      <Map<String, dynamic>>[].obs;

  final List<Map<String, String>> chatHistory = <Map<String, String>>[].obs;
  RxList<Map<String, dynamic>> chatMetadata = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> chatLogsForSession =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  Future<void> fetchChats() async {
    try {
      final jwt = getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/therapist/chat/logs'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        chatMessages.value = jsonList
            .map((jsonItem) => jsonItem as Map<String, dynamic>)
            .toList();
      } else {
        CommonSnackbar.show(
          text: "Error fetching chats",
          subtext: response.body,
          color: "red",
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateSessionStatus(String sessionId, String status) async {
    try {
      final jwt = getJwt();
      final response = await http.put(
        Uri.parse(
            '$backendUrl/therapist/chat/logs/$sessionId/status?status=$status'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        CommonSnackbar.show(
          text: "Chat status updated",
          subtext: "",
          color: "green",
        );
        fetchChats();
      } else {
        CommonSnackbar.show(
          text: "Error updating chat status",
          subtext: response.body,
          color: "red",
        );
      }
    } catch (e) {
      CommonSnackbar.show(
        text: "Error updating chat status",
        subtext: e.toString(),
        color: "red",
      );
    }
  }

  Future<void> acceptSession(String sessionId) async {
    try {
      final jwt = getJwt();
      final response = await http.put(
        Uri.parse('$backendUrl/therapist/chat/logs/$sessionId/accept'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {
        CommonSnackbar.show(
          text: "Chat accepted",
          subtext: "You are now assigned to this chat",
          color: "green",
        );
        fetchChats();
      } else {
        CommonSnackbar.show(
          text: "Error accepting chat",
          subtext: response.body,
          color: "red",
        );
      }
    } catch (e) {
      CommonSnackbar.show(
        text: "Error accepting chat",
        subtext: e.toString(),
        color: "red",
      );
    }
  }

  Future<void> getChatsForSession(String sessionId) async {
    try {
      final jwt = getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/therapist/chat/logs/$sessionId'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 200) {

        String decodedResponse = utf8.decode(response.bodyBytes);
        List<dynamic> jsonList = jsonDecode(decodedResponse);
        chatLogsForSession.value = jsonList
            .map((jsonItem) => jsonItem as Map<String, dynamic>)
            .toList();
      } else {
        CommonSnackbar.show(
          text: "Error fetching chats",
          subtext: response.body,
          color: "red",
        );
      }
    } catch (e) {
      CommonSnackbar.show(
        text: "Error fetching chats",
        subtext: e.toString(),
        color: "red",
      );
    }
  }
}
