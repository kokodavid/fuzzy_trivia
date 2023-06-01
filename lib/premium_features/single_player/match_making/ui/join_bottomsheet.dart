import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/button.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/input_widget.dart';

import '../../../../constants.dart';

class JoinGameModal extends StatefulWidget {
  const JoinGameModal({super.key});

  @override
  State<JoinGameModal> createState() => _JoinGameModalState();
}

class _JoinGameModalState extends State<JoinGameModal> {
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
              children: const [
                InputWidget(
                  color: inputBackground,
                  hint: 'Enter room id',
                ),
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
                        onPressed: () {})),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
