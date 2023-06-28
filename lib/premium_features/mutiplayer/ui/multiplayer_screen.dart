
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/matchmaking_screen.dart';
import 'package:get/get.dart';

import 'join_room.dart';

class MultiPlayerScreen extends StatefulWidget {
  const MultiPlayerScreen({super.key, this.mode});

    final String? mode;

  @override
  State<MultiPlayerScreen> createState() => _MultiPlayerScreenState();
}

class _MultiPlayerScreenState extends State<MultiPlayerScreen> {
  final AuthController _authController = Get.put(AuthController());


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
                  Get.to( MatchmakingScreen(mode: widget.mode,));
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
                      return const JoinGameDialog();
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
