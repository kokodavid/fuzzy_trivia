import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/screens/quiz/quiz_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../questions/controller/question_controller.dart';
import '../quiz/mutiplayer/controller/multiplayer_controller.dart';

class LobbyScreen extends StatefulWidget {
  LobbyScreen({Key? key, this.roomId}) : super(key: key);

  final String? roomId;

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final MultiplayerController _multiplayerController =
      Get.put(MultiplayerController()); 

  final _mFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
            if (gameRoomData!['status'] == "waiting") {
              Get.put(QuestionController()).fetchQuestions();
              return Text(
                  "Waiting for Opponents to join lobby #${widget.roomId!}");
            } else {
             
              return QuizScreen();
            }
          }
        }),
      ),
    );
  }
}
