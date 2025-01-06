import 'package:get/get.dart';

class EmergencyChatController extends GetxController {
  final RxList<Map<String, dynamic>> chatMessages = <Map<String, dynamic>>[].obs;

  var chatMetadata;

  Future<void> fetchChats() async {
    await Future.delayed(const Duration(seconds: 2));
    final List<Map<String, dynamic>> fetchedChats = [
      {
        "name": "John Doe",
        "phone": 99127890990,
        "mail": "awsdfewrgt",
        "asked_at": "2025-01-06T21:04:15.445Z",
        "session_id": "session123",
        "response": "Help is on the way!"
      },
      {
        "name": "Jane Smith",
        "phone": 9123456789,
        "mail": "janesmith@example.com",
        "asked_at": "2025-01-06T22:10:30.123Z",
        "session_id": "session456",
        "response": "Stay calm, assistance is coming."
      }
    ];
    chatMessages.value = fetchedChats;
  }

  getChatsForSession(chat) {}
}
