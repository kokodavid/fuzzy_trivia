import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(top: kToolbarHeight),
          child: Container(
            height: 200,
            child: Column(
              children: [
                Text("Waiting for Opponents to join lobby #${widget.roomId!}"),
                Text(_multiplayerController.status!)
              ],
            ),
          )),
    );
  }
}
