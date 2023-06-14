import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/friends/ui/friends_bottomsheet.dart';
import 'package:fuzzy_trivia/premium_features/leaderboard/leaderboard.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profile_bottomsheet.dart';
import 'package:fuzzy_trivia/premium_features/profile/ui/profile_page.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/circular_avatar.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/lobby_bottomsheet.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/matchmaking_screen.dart';
import 'package:get/get.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

import '../auth/controller/auth_controller.dart';
import '../constants.dart';
import '../screens/quiz/quiz_screen.dart';
import 'leaderboard/leaderboard_controller.dart';
import 'mutiplayer/ui/join_room.dart';

class PremiumHome extends StatefulWidget {
  const PremiumHome({super.key});

  @override
  State<PremiumHome> createState() => _PremiumHomeState();
}

class _PremiumHomeState extends State<PremiumHome> {
  final AuthController authController = Get.put(AuthController());

  final ProfileController profileController = Get.put(ProfileController());
  final LeaderboardController leaderboardController =
      Get.put(LeaderboardController());

  @override
  void initState() {
    profileController.getUserData(authController.user.value!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffE1E0E0),
      body: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return const ProfileBottomSheet();
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: LoadingCircleAvatar(
                                imageUrl:
                                    profileController.profilePicture.value,
                                radius: 27,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello ${profileController.username}",
                                  style: const TextStyle(
                                      fontSize: 20, color: primaryGreen),
                                ),
                                const Text(
                                  "Profile and settings",
                                  style:
                                      TextStyle(fontSize: 17, color: textGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return const FriendsBottomSheet();
                              },
                            );
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                child: Image.asset(
                                  'assets/icons/friends.png',
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const QuizScreen(
                        mode: 'random',
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 90,
                  decoration: BoxDecoration(
                      color: secondaryGreen,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 260,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Play Random Questions",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                "Play randomly generated questions and earn points.",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15, color: textGrey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(16),
                          child: Image.asset("assets/icons/gma_plan.png"))
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: const Text(
                        "Leaderboard",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: primaryGreen,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LeaderboardPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          "View all",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: primaryGreen,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 265,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: leaderboardController.buildLeaderboard()),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Text(
                    "Play Now",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        color: primaryGreen,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return const LobbyModalSheet();
                        },
                      );
                    },
                    child: Container(
                      height: 150,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "One V One Battle",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryGreen,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Play against your friend.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.all(10),
                                child:
                                    Image.asset("assets/icons/multiplayer.png"))
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MatchmakingScreen(
                            mode: 'premium_single',
                          ));
                    },
                    child: Container(
                      height: 150,
                      width: 160,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Solo Play",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryGreen,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "Create a solo match.",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                    "assets/icons/single_player.png"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
