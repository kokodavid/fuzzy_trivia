import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';

import '../../../screens/quiz/quiz_screen.dart';

class JoinGameDialog extends StatefulWidget {
  const JoinGameDialog({super.key, this.roomId});

  final String? roomId;

  @override
  _JoinGameDialogState createState() => _JoinGameDialogState();
}

class _JoinGameDialogState extends State<JoinGameDialog> {
  final AuthController _authController = Get.put(AuthController());
  

  final _mFirestore = FirebaseFirestore.instance;
  final String? mode = 'premium_multi';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: StreamBuilder(
        stream:
            _mFirestore.collection('gameRooms').doc(widget.roomId).snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Data not available',
              ),
            );
          } else {
            DocumentSnapshot<Map<String, dynamic>>? gameRoomData =
                snapshot.data;

            String player =
                gameRoomData!['hostId'] == _authController.user.value!.uid
                    ? 'host'
                    : 'player2';

            String category = gameRoomData['category'];
            int questions = gameRoomData['limit'];
            String difficulty = gameRoomData['difficulty'];

            if (gameRoomData['status'] == "waiting") {
              return SizedBox(
                height: 240,
                child: Column(
                  children: [
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
                            'Game Room',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 35, horizontal: 7),
                      child: const Text(
                        "Waiting for opponents to join  share id.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 59,
                      width: 122,
                      decoration: BoxDecoration(
                          color: secondaryGreen,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          widget.roomId.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return QuizScreen(
                mode: mode,
                roomId: widget.roomId,
                player: player,
                category: category,
                difficulty: difficulty,
                questions: questions,
              );
            }
          }
        }),
      ),
    );
  }
}
