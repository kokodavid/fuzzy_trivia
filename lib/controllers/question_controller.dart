import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fuzzy_trivia/models/trivia_model.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../models/Questions.dart';
import '../screens/score/score_screen.dart';
import 'package:http/http.dart' as http;

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  late Questions questionModel;

  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;

  PageController get pageController => this._pageController;

  List<dynamic> _questionList = [];
  List<dynamic> get questionList => _questionList;

  final List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late String _correctAns;
  String get correctAns => this._correctAns;

  late String _selectedAns;
  String get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 1000), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(
      Uri.parse(
          'https://the-trivia-api.com/api/questions?limit=15&difficulty=medium'),
    );
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> jsonQuestions = jsonBody;
      final List<Questions> questions = jsonQuestions
          .map((jsonQuestion) => Questions.fromJson(jsonQuestion))
          .toList();
      _questionList = questions;
      update();

      log(_questionList.toString());
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void checkAns(String answer, String selectedAnswer) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = answer;
    _selectedAns = selectedAnswer;

    log(_selectedAns);

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questionList.length) {
      _isAnswered = false;

      _pageController.nextPage(
          duration: Duration(milliseconds: 1000), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
