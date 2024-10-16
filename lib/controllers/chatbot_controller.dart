import 'package:get/get.dart';
import 'package:fsui/constants.dart'; // Ensure AppColors is imported

class ChatBotController extends GetxController {
  var question = 'How are you feeling?'.obs;
  var answers = <Map<String, String>>[].obs;
  var selectedAnswers = <String>[].obs;

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
    selectedAnswers.add(answers.firstWhere((a) => a['id'] == answerId)['text']!);
    fetchNewQuestionAndAnswers(answerId);
  }

  void fetchNewQuestionAndAnswers(String answerId) {
    if (answerId == '1') {
      question.value = 'Why do you feel Not OK?';
      answers.value = [
        {'id': '5', 'text': 'I am feeling tired'},
        {'id': '6', 'text': 'I have a headache'},
      ];
    } else if (answerId == '2') {
      question.value = 'What makes you feel OK?';
      answers.value = [
        {'id': '7', 'text': 'Just relaxing'},
        {'id': '8', 'text': 'Talking to friends'},
      ];
    }
  }
}
