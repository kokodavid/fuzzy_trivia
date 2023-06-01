import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/ui/join_room.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/button.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/join_bottomsheet.dart';
import 'package:get/get.dart';

import 'matchmaking_screen.dart';

class LobbyModalSheet extends StatefulWidget {
  const LobbyModalSheet({super.key});

  @override
  State<LobbyModalSheet> createState() => _LobbyModalSheetState();
}

class _LobbyModalSheetState extends State<LobbyModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
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
              'Game Lobby',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            const SizedBox(height: 20.0),
            Button(
              title: "Create Room",
              color: secondaryGreen,
              txtColor: Colors.white,
              onPressed: () {
                 Get.to(()=> const MatchmakingScreen(
                        mode: 'premium_multi',
                      ));
              },
            ),
            const SizedBox(height: 20.0),
            Button(
              title: "Join Room",
              color: buttonB,
              txtColor: second,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const JoinGameModal(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
