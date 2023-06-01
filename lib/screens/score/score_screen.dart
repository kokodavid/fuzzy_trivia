import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../auth/controller/auth_controller.dart';
import '../../constants.dart';
import '../../premium_features/single_player/match_making/ui/matchmaking_screen.dart';
import '../../questions/controller/question_controller.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key, this.roomId}) : super(key: key);

  final String? roomId;
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final _mFirestore = FirebaseFirestore.instance;
  QuestionController qnController = Get.put(QuestionController());
  ProfileController profileController = Get.put(ProfileController());
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    profileController.getUserData(authController.user.value!.uid);

    profileController.updateScores(
        authController.user.value!.uid, qnController.numOfCorrectAns.value);

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<QuestionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream:
            _mFirestore.collection('gameRooms').doc(widget.roomId).snapshots(),
        builder: ((context, snapshot) {
          // DocumentSnapshot<Map<String, dynamic>>? gameRoomData = snapshot.data;

          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: kToolbarHeight * 1.5),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Score',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryGreen),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: secondaryGreen.withOpacity(0.73),
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Image.asset('assets/images/trophy.png')),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "You get +${qnController.numOfCorrectAns * 10} Quiz Points",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  height: 58,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white.withOpacity(0.29)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        "New Score: ${profileController.newScore.toString()}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "CORRECT ANSWERS",
                                    style: TextStyle(color: textGrey),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "${qnController.numOfCorrectAns}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "INCORRECT ANSWERS",
                                      style: TextStyle(color: textGrey),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "${qnController.answeredQuestions.value - qnController.numOfCorrectAns.value}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "COMPLETION",
                                    style: TextStyle(color: textGrey),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "${((qnController.answeredQuestions.value / qnController.questionList.length) * 100).toStringAsFixed(0)}%",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "SKIPPED QUESTIONS",
                                      style: TextStyle(color: textGrey),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "${(qnController.questionList.length - qnController.answeredQuestions.value)}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Get.deleteAll();
                            Get.to(() => const PremiumHome());
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            height: 58,
                            width: 235,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: second),
                            child: const Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  "Done",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 66,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          height: 58,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: secondaryGreen)),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Center(
                                child: Icon(
                              Icons.share,
                              color: second,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
