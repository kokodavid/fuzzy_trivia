import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../constants.dart';
import '../../../questions/controller/question_controller.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 15,
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        color: primaryGreen,
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Stack(
            children: [
              // LayoutBuilder provide us the available space for the conatiner
              // constraints.maxWidth needed for our animation
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  // from 0 to 1 it takes 60s
                  width: constraints.maxWidth * controller.animation.value,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              // Positioned.fill(
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: kDefaultPadding / 2),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text("${(controller.animation.value * 15).round()} sec"),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
