import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/controller/multiplayer_controller.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/ui/join_room.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/button.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/numbers_widget.dart';
import 'package:fuzzy_trivia/screens/quiz/quiz_screen.dart';
import 'package:get/get.dart';

import '../../../../auth/controller/auth_controller.dart';
import '../controller/premium_player_controller.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key, this.mode});

  final String? mode;

  @override
  // ignore: library_private_types_in_public_api
  _MatchmakingScreenState createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen> {
  PremiumPlayerController premController = Get.put(PremiumPlayerController());
  MultiplayerController multiController = Get.put(MultiplayerController());
  final _formKey = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());

  String? category;
  String? difficulty;
  String? questions;
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight * 1.5),
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
                  'Create Quiz',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Number of Questions",
                    style: TextStyle(
                        color: primaryGreen, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: InputNumbers(
                      formKey: _formKey,
                      color: Colors.white,
                      hint: 'Range between 1 - 50',
                      controller: multiController.controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          Get.snackbar(
                            'Number of Questions',
                            'Please enter a value',
                            backgroundColor: Colors.red,
                          );

                          return '';
                        }
                        int? enteredValue = int.tryParse(value);
                        if (enteredValue == null) {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              'Number of Questions',
                              'Please enter a valid number');
                          return '';
                        }
                        if (enteredValue > 50) {
                          Get.snackbar(
                              'Number of Questions',
                              backgroundColor: Colors.red,
                              'Value must be less than or equal to 50');
                          return '';
                        }
                        return null; // Validation passed
                      },
                    )),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Questions Category",
                        style: TextStyle(
                            color: primaryGreen, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Obx(
                        () => Wrap(
                          spacing: 8.30, // Adjust the spacing between cards
                          runSpacing: 15.0, // Adjust the spacing between rows
                          children: premController.categories
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            final isSelected =
                                multiController.selectedIndex.value == index;

                            return GestureDetector(
                              onTap: () {
                                multiController.selectCategoryItem(index);

                                category = premController.originCategory
                                    .elementAt(index);
                              },
                              child: Container(
                                constraints: const BoxConstraints(
                                    minWidth:
                                        80), // Adjust the minimum width of each card
                                decoration: BoxDecoration(
                                  color: !isSelected
                                      ? secondaryGreen
                                      : primaryGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      8.0), // Adjust the padding within the card
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Questions Difficulty",
                        style: TextStyle(
                            color: primaryGreen, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Obx(
                        () => Wrap(
                          spacing: 40.0,
                          children: premController.difficulties
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            final isSelected =
                                multiController.selectedDifIndex.value == index;

                            return GestureDetector(
                              onTap: () {
                                multiController.selectDifItem(index);

                                difficulty =
                                    premController.originDiff.elementAt(index);
                                log("difficulty ${difficulty.toString()}");
                              },
                              child: Container(
                                constraints: const BoxConstraints(minWidth: 80),
                                decoration: BoxDecoration(
                                  color: !isSelected
                                      ? secondaryGreen
                                      : primaryGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Button(
              title: 'Create Match',
              color: secondaryGreen,
              onPressed: () async {
                try {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    log("LOG${multiController.controller.text}");

                    await multiController.createNewGameRoom(
                        authController.user.value!.uid,
                        category,
                        difficulty,
                        int.parse(multiController.controller.text));

                    await multiController.getRoomData(multiController.roomId);

                    widget.mode != 'premium_single'
                        ? _showDialog()
                        : Get.to(() => QuizScreen(
                              mode: widget.mode,
                              category: category,
                              difficulty: difficulty,
                              questions:
                                  int.parse(multiController.controller.text),
                            ));
                  }
                } catch (e) {
                  log(e.toString());
                  Get.snackbar(
                      'Error',
                      backgroundColor: Colors.red,
                      'All fields are required');
                }
              },
              txtColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  void _showDialog() {
    dialogContext = context;
    showDialog(
      barrierDismissible: false,
      context: dialogContext!,
      builder: (context) {
        return JoinGameDialog(roomId: multiController.roomId);
      },
    );
  }
}
