import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../questions/controller/question_controller.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key, this.roomId}) : super(key: key);

  final String? roomId;
  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final _mFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return Scaffold(
      body: StreamBuilder(
        stream:
            _mFirestore.collection('gameRooms').doc(widget.roomId).snapshots(),
        builder: ((context, snapshot) {
          DocumentSnapshot<Map<String, dynamic>>? gameRoomData =
                snapshot.data;
          return Stack(
            fit: StackFit.expand,
            children: [
              SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
              Column(
                children: [
                  const Spacer(flex: 3),
                  Text(
                    "Score",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: kSecondaryColor),
                  ),
                  const Spacer(),
                  Text(
                    "${qnController.numOfCorrectAns * 10}/${qnController.questionList.length * 10}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: kSecondaryColor),
                  ),
                  const Spacer(flex: 3),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
