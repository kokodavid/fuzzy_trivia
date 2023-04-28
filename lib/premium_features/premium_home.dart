import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/matchmaking_screen.dart';
import 'package:get/get.dart';

import '../screens/quiz/quiz_screen.dart';

class PremiumHome extends StatelessWidget {
  const PremiumHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text(
                "Hello David",
                style: TextStyle(fontSize: 24),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Leaderboard',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Leaderboard',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(const QuizScreen(mode: 'premium'));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(color: Colors.red),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'MutiPlayer',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                         Get.to(const MatchmakingScreen());

                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(color: Colors.green),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Single mode',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
