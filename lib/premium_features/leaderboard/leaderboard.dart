
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/leaderboard/leaderboard_controller.dart';
import 'package:get/get.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final LeaderboardController leaderboardController = Get.put(LeaderboardController());
  final AuthController authController = Get.put(AuthController());
    

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            const SizedBox(
              height: kTextTabBarHeight * 1.5,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    'Leaderboard',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: leaderboardController.buildLeaderboard()),
            ),
          ],
        ));
  }
}
