import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/screens/quiz/quiz_screen.dart';
import 'package:get/get.dart';

class LobbyScreen extends StatefulWidget {
  LobbyScreen({Key? key, this.roomId}) : super(key: key);

  final String? roomId;

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
 
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  final _mFirestore = FirebaseFirestore.instance;
  final String? mode = 'premium';

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

            String player = gameRoomData!['hostId'] == _authController.user.value!.uid
                ? 'host'
                : 'player2';

            log("PLAYER===> $player");
            if (gameRoomData['status'] == "waiting") {
              return Text(
                  "Waiting for Opponents to join lobby #${widget.roomId!}");
            } else {
              return QuizScreen(
                mode: mode,
                roomId: widget.roomId,
                player: player,
              );
            }
          }
        }),
      ),
    );
  }
}
