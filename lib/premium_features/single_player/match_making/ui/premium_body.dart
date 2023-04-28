import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../../questions/controller/question_controller.dart';
import '../../../../questions/data/model/qustions_model.dart';
import '../../../../screens/quiz/components/progress_bar.dart';
import '../../../../screens/quiz/components/question_card.dart';

class PremiumBody extends StatefulWidget {
  const PremiumBody({Key? key, required this.mode, required this.player, this.roomId,this.category,this.difficulty,this.questions})
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
    return FutureBuilder<List<Questions>>(
      future: questionController.fetchPremiumQuestions(widget.questions,widget.category,widget.difficulty),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: ProgressBar(),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Obx(
                        () => Text.rich(
                          TextSpan(
                            text:
                                "Question ${questionController.questionNumber.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: kSecondaryColor),
                            children: [
                              TextSpan(
                                text: "/${snapshot.data!.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: kSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                ),
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    ); 
  }
}