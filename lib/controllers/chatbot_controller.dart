import 'package:get/get.dart';
import 'package:fsui/constants.dart'; // Ensure AppColors is imported

class ChatBotController extends GetxController {
  var questions = <String>[].obs; // List to hold all questions
  var answers = <Map<String, String>>[].obs;
  var selectedAnswers = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialAnswers();
  }

  void fetchInitialAnswers() {
    questions.add("Why do you feel Not OK ");
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
    String newQuestion;
    if (answerId == '1') {
      newQuestion = 'What are you feeling then?';
      answers.value = [
        {'id': '5', 'text': 'I am feeling tired'},
        {'id': '6', 'text': 'I have a headache'},
      ];
    } else if (answerId == '2') {
      newQuestion = 'What makes you feel OK?';
      answers.value = [
        {'id': '7', 'text': 'Just relaxing'},
        {'id': '8', 'text': 'Talking to friends'},
      ];
    } else if (answerId == '3') {
      newQuestion = 'How long have you been feeling this way?';
      answers.value = [
        {'id': '9', 'text': 'A few days'},
        {'id': '10', 'text': 'A few weeks'},
      ];
    } else if (answerId == '4') {
      newQuestion = 'What do you usually do to feel better?';
      answers.value = [
        {'id': '11', 'text': 'Go for a walk'},
        {'id': '12', 'text': 'Listen to music'},
      ];
    } else if (answerId == '5') {
      newQuestion = 'Have you talked to someone about how you feel?';
      answers.value = [
        {'id': '13', 'text': 'Yes, I have'},
        {'id': '14', 'text': 'No, I haven\'t'},
      ];
    } else if (answerId == '6') {
      newQuestion = 'Would you like to try some relaxation techniques?';
      answers.value = [
        {'id': '15', 'text': 'Yes, that would help'},
        {'id': '16', 'text': 'No, I prefer other methods'},
      ];
    } else {
      newQuestion = 'How are you feeling today?';
      answers.value = [
        {'id': '17', 'text': 'I feel great!'},
        {'id': '18', 'text': 'I\'m okay.'},
        {'id': '19', 'text': 'I need help.'},
      ];
    }
    
    questions.add(newQuestion); 
  }
}
