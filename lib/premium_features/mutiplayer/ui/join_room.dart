import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/questions/controller/question_controller.dart';
import 'package:fuzzy_trivia/screens/lobby/lobby_screen.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/controller/multiplayer_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../repository/multiplayer_repository.dart';

class JoinGameDialog extends StatefulWidget {
  @override
  _JoinGameDialogState createState() => _JoinGameDialogState();
}

class _JoinGameDialogState extends State<JoinGameDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _roomId;
  final MultiplayerController _multiPlayerController = MultiplayerController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      title: const Text(
        'Join Game Room',
        style: TextStyle(color: Colors.black),
      ),
      content: Container(
        child: Form(
          key: _formKey,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Room ID',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a room ID';
              }
              return null;
            },
            onSaved: (value) {
              _roomId = value!;
            },
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Join'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await _multiPlayerController.validateRoomId(_roomId);
              await _multiPlayerController
                  .verifyPlayer(_authController.user.value!.uid);

              if (_multiPlayerController.rooms == 0) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text('You are already in the lobby with another device'),
                  backgroundColor: Colors.red,
                ));
              } else {
                _multiPlayerController.joinGame(
                    _roomId, _authController.user.value!.uid);
                _multiPlayerController.updateGameStatus(_roomId);
                Get.to(LobbyScreen(
                  roomId: _roomId,
                ));
              }
            }
          },
        ),
      ],
    );
  }
}
