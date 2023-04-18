import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../questions/controller/question_controller.dart';
import '../../../questions/data/model/qustions_model.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
 QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Questions question;

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question!,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kBlackColor),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, index) {
                // shuffledAns = [...shuffle(shuffledAns)];

                // ignore: avoid_single_cascade_in_expression_statements

                log("ANSWER ===> ${question.correctAnswer}");
                log("SHUFFLED ANSWERS ===> $shuffledAns");

                return Option(
                  text: shuffledAns[index],
                  number: index,
                  index: shuffledAns.elementAt(index),
                  press: ()=> controller.checkAns(question.correctAnswer!, shuffledAns.elementAt(index)),
                );
              },
            ),
          )
     
        ],
      ),
    );
  }
}
