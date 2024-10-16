import 'package:get/get.dart';

class ChatBotController extends GetxController {
  var question = 'How are you feeling?'.obs;
  var answers = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialAnswers();
  }

  void fetchInitialAnswers() {
    answers.value = [
      {'id': '1', 'text': 'Not OK'},
      {'id': '2', 'text': 'OK'},
      {'id': '3', 'text': 'Feeling Great'},
      {'id': '4', 'text': 'Could be Better'},
    ];
  }

  void selectAnswer(String answerId) {
    question.value =
        'Tell me more about why you feel ${answers.firstWhere((a) => a['id'] == answerId)['text']}.';
  }
}
