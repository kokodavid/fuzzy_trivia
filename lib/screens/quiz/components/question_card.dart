import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../questions/controller/question_controller.dart';
import '../../../questions/data/model/qustions_model.dart';
import 'option.dart';

// ignore: must_be_immutable
class QuestionCard extends StatelessWidget {
  QuestionCard(
      {Key? key,
      required this.question,
      required this.mode,
      this.player,
      this.roomId})
      : super(key: key);

  final Questions question;
  final String? mode;
  final String? player;
  final String? roomId;

  List shuffle(List items) {
    var random = m.Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  List<String> allAnswers = [];

  List<String> shuffledAns = [];

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());

    allAnswers = [...?question.incorrectAnswers, question.correctAnswer!];

    shuffledAns = [...shuffle(allAnswers)];

    log("=====> Mode $mode");
    log("=====> Player $player");
    log("=====> roomId $roomId");

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Obx(
              () => Text.rich(
                TextSpan(
                  text: "Question ${controller.questionNumber.value}",
                  style: const TextStyle(fontSize: 16, color: primaryGreen),
                  children: [
                    TextSpan(
                      text: " of ${controller.questionList.length}",
                      style: const TextStyle(fontSize: 16, color: primaryGreen),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              question.question!,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: kBlackColor),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 4,
              itemBuilder: (BuildContext context, index) {
                return Option(
                  text: shuffledAns[index],
                  number: index,
                  index: shuffledAns.elementAt(index),
                  press: () => mode != 'premium_multi'
                      ? controller.checkAns(
                          question.correctAnswer!, shuffledAns.elementAt(index))
                      : player == 'host'
                          ? controller.checkAnsAndUpload(
                              question.correctAnswer!,
                              shuffledAns.elementAt(index),
                              roomId)
                          : controller.checkPlayer2AnsAndUpload(
                              question.correctAnswer!,
                              shuffledAns.elementAt(index),
                              roomId),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
