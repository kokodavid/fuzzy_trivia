import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/controller/multiplayer_controller.dart';
import 'package:get/get.dart';

import '../../../screens/lobby/lobby_screen.dart';
import 'join_room.dart';

class MultiPlayerScreen extends StatelessWidget {
  MultiPlayerScreen({super.key});

  final AuthController _authController = Get.put(AuthController());
  final MultiplayerController _multiplayerController =
      Get.put(MultiplayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          margin: const EdgeInsets.only(top: kToolbarHeight),
          child: Column(
            children: [
              Text("Hello ${_authController.user.value!.displayName!}"),
              GestureDetector(
                onTap: () async {
                  await _multiplayerController
                      .createNewGameRoom(_authController.user.value!.uid);

                  await _multiplayerController.getRoomData(
                    _multiplayerController.roomId,
                  );
                  Get.to(LobbyScreen(
                    roomId: _multiplayerController.roomId,
                  ));
                  log(_multiplayerController.roomId!);
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.red),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Create Game Room"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return JoinGameDialog();
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(color: Colors.green),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Join Game Room"),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
