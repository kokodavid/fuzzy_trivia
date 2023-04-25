import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fuzzy_trivia/questions/data/model/qustions_model.dart';
import 'package:fuzzy_trivia/screens/quiz/mutiplayer/repository/multiplayer_repository.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../screens/score/score_screen.dart';

class QuestionController extends GetxController
    // ignore: deprecated_member_use
    with SingleGetTickerProviderMixin {
  final MultiPlayerRepository _multiPlayerRepository = MultiPlayerRepository();

  late AnimationController _animationController;
  late Animation _animation;
  late Questions questionModel;

  Animation get animation => _animation;

  late PageController _pageController;

  PageController get pageController => _pageController;

  List<dynamic> _questionList = [];
  List<dynamic> get questionList => _questionList;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late String _correctAns;
  String get correctAns => _correctAns;

  late String _selectedAns;
  String get selectedAns => _selectedAns;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  String? hostScore;
  String? player2Score;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  Future<List<Questions>> fetchBasicQuestions() async {
    final response = await http.get(
      Uri.parse('https://the-trivia-api.com/api/questions?limit=10'),
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
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future<List<Questions>> fetchPremiumQuestions() async {
    final response = await http.get(
      Uri.parse('https://the-trivia-api.com/api/questions?limit=15'),
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
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void checkAns(String answer, String selectedAnswer) {
    _isAnswered = true;
    _correctAns = answer;
    _selectedAns = selectedAnswer;

    log(_selectedAns);

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();
    update();

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  checkAnsAndUpload(String answer, String selectedAnswer, roomId) {
    _isAnswered = true;
    _correctAns = answer;
    _selectedAns = selectedAnswer;

    log(_selectedAns);

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();
    update();

        _multiPlayerRepository.uploadHostScores(roomId, _numOfCorrectAns.toString());

    _multiPlayerRepository.uploadHostScores(roomId,  _numOfCorrectAns.toString());

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }

   checkPlayer2AnsAndUpload(String answer, String selectedAnswer, roomId) {
    _isAnswered = true;
    _correctAns = answer;
    _selectedAns = selectedAnswer;

    log(_selectedAns);

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();
    update();

    _multiPlayerRepository.uploadPlayer2Scores(roomId, _numOfCorrectAns.toString());

    Future.delayed(const Duration(seconds: 2), () {
      nextQuestion();
    });
  }




  void nextQuestion() {
    if (_questionNumber.value != _questionList.length) {
      _isAnswered = false;

      _pageController.nextPage(
          duration: const Duration(milliseconds: 1000), curve: Curves.ease);

      _animationController.reset();

      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Get.to(const ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
