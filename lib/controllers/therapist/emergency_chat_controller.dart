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

  // Future<void> fetchChats() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   final List<Map<String, dynamic>> fetchedChats = [
  //     {
  //       "name": "John Doe",
  //       "phone": 99127890990,
  //       "mail": "awsdfewrgt",
  //       "asked_at": "2025-01-06T21:04:15.445Z",
  //       "session_id": "session123",
  //       "response": "Help is on the way!"
  //     },
  //     {
  //       "name": "Jane Smith",
  //       "phone": 9123456789,
  //       "mail": "janesmith@example.com",
  //       "asked_at": "2025-01-06T22:10:30.123Z",
  //       "session_id": "session456",
  //       "response": "Stay calm, assistance is coming."
  //     }
  //   ];
  //   chatMessages.value = fetchedChats;
  // }

  Future<void> fetchChats() async {
    try {
      final jwt = getJwt();
      final response = await http.get(
        Uri.parse('$backendUrl/therapist/blogs/all'),
        headers: {
          'Authorization': 'Bearer $jwt',
        },
      );
      if (response.statusCode == 201) {
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

  getChatsForSession(chat) {}
}
