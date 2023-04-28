import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/questions/controller/question_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../screens/quiz/quiz_screen.dart';
import '../controller/premium_player_controller.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  _MatchmakingScreenState createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {

  QuestionController qnController = Get.put(QuestionController());
  PremiumPlayerController premController = Get.put(PremiumPlayerController());


  int _numberOfQuestions = 1;
  String _category = 'music';
  String _difficulty = 'easy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchmaking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: _numberOfQuestions,
              items: List.generate(20, (index) => index + 1)
                  .map((value) => DropdownMenuItem(
                        child: Text('$value'),
                        value: value,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _numberOfQuestions = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _category,
              items: premController.categories
                  .map((value) => DropdownMenuItem(
                        child: Text('$value'),
                        value: value,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _category = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _difficulty,
              items: premController.difficulties
                  .map((value) => DropdownMenuItem(
                        child: Text('$value'),
                        value: value,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                Get.to( QuizScreen(
                  mode: 'premium',
                  category: _category,
                  difficulty: _difficulty,
                  questions: _numberOfQuestions,

                  ));

              },
              child: const Text('Find Match'),
            ),
          ],
        ),
      ),
    );
  }
}
