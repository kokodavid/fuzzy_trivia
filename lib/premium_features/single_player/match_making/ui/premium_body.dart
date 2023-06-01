import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../questions/controller/question_controller.dart';
import '../../../../questions/data/model/qustions_model.dart';
import '../../../../screens/quiz/components/progress_bar.dart';
import '../../../../screens/quiz/components/question_card.dart';

class PremiumBody extends StatefulWidget {
  const PremiumBody(
      {Key? key,
      required this.mode,
      required this.player,
      this.roomId,
      this.category,
      this.difficulty,
      this.questions})
      : super(key: key);

  final String? mode;
  final String? player;
  final String? roomId;
  final String? category;
  final String? difficulty;
  final int? questions;

  @override
  State<PremiumBody> createState() => _PremiumBodyState();
}

class _PremiumBodyState extends State<PremiumBody> {
  QuestionController questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight * 1.5),
      color: secondaryGreen,
      child: FutureBuilder<List<Questions>>(
        future: widget.mode != 'random'
            ? questionController.fetchPremiumQuestions(
                widget.questions, widget.category, widget.difficulty)
            : questionController.premiumRandomQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        Container(
                          height: 30,
                          width: 66,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Obx(
                              () => Row(
                                children: [
                                  Text(
                                    "${questionController.numOfCorrectAns * 10}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    "assets/icons/puzzle.png",
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: ProgressBar(),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: kDefaultPadding),
                  Expanded(
                    child: PageView.builder(
                      // Block swipe to next qn
                      physics: const NeverScrollableScrollPhysics(),
                      controller: questionController.pageController,
                      onPageChanged: questionController.updateTheQnNum,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => QuestionCard(
                        mode: widget.mode,
                        player: widget.player,
                        question: snapshot.data![index],
                        roomId: widget.roomId,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Text("FAiled");
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
