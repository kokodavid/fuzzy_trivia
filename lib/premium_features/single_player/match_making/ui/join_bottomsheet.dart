import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/controller/multiplayer_controller.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/button.dart';
import 'package:get/get.dart';

import '../../../../auth/controller/auth_controller.dart';
import '../../../../constants.dart';
import '../../../../screens/lobby/lobby_screen.dart';
import 'numbers_widget.dart';

class JoinGameModal extends StatefulWidget {
  const JoinGameModal({super.key});

  @override
  State<JoinGameModal> createState() => _JoinGameModalState();
}

class _JoinGameModalState extends State<JoinGameModal> {
  final _formKey = GlobalKey<FormState>();
  final MultiplayerController multiPlayerController = MultiplayerController();
  final AuthController authController = Get.put(AuthController());
  late String roomId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 4,
            width: 44,
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(4)),
          ),
          const Text(
            'Join Lobby',
            style: TextStyle(fontSize: 19.0, color: Colors.black),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                InputNumbers(
                  formKey: _formKey,
                  color: inputBackground,
                  hint: 'Enter room id',
                  validator: (value) {
                    if (value!.isEmpty) {
                      Get.snackbar(
                          backgroundColor: Colors.red,
                          'Room Id',
                          'Please enter a valid id');
                    }
                    return null;
                  },
                  onSaved: (value) {
                    roomId = value!;
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: Button(
                        title: 'Cancel',
                        color: secondaryGreen,
                        txtColor: Colors.white,
                        onPressed: () {})),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Button(
                        title: 'Join',
                        color: buttonB,
                        txtColor: secondaryGreen,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await multiPlayerController.validateRoomId(roomId);
                            //verify player
                            //           await multiPlayerController
                            // .verifyPlayer(authController.user.value!.uid);

                            if (multiPlayerController.rooms == 0) {
                              Get.snackbar(
                                  backgroundColor: Colors.red,
                                  'Error',
                                  'Room not found');
                            } else {
                              multiPlayerController.joinGame(
                                  roomId, authController.user.value!.uid);
                              multiPlayerController.updateGameStatus(roomId);
                              Get.to(LobbyScreen(
                                roomId: roomId,
                              ));
                            }
                          }
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
