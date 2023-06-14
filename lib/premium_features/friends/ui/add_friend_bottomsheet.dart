import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/input_widget.dart';

import '../../../constants.dart';
import '../../single_player/match_making/ui/button.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
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
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 4,
            width: 44,
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(4)),
          ),
          const Text(
            'Add friend',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Container(
                  child: const InputWidget(
                    color: inputBackground,
                    hint: 'Enter Username',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
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
                              title: 'Add',
                              color: buttonB,
                              txtColor: secondaryGreen,
                              onPressed: () async {})),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
