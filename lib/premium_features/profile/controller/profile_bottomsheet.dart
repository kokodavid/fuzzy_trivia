import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:fuzzy_trivia/premium_features/profile/ui/profile_page.dart';
import 'package:get/get.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

import '../../leaderboard/leaderboard_controller.dart';
import '../../single_player/match_making/ui/button.dart';
import '../../single_player/match_making/ui/circular_avatar.dart';

class ProfileBottomSheet extends StatefulWidget {
  const ProfileBottomSheet({super.key});

  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  final AuthController authController = Get.put(AuthController());

  final LeaderboardController boardController =
      Get.put(LeaderboardController());

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Profile',
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: buttonGrey),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: LoadingCircleAvatar(
                            imageUrl: profileController.profilePicture.value,
                            radius: 55,
                          ),
                        ),
                        Text(
                          profileController.username.value,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 19),
                        ),
                        Text(
                          authController.user.value!.displayName!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/icons/points.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    profileController.totalScore.toString(),
                                    style: const TextStyle(
                                        color: thirdColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    "Quiz Points",
                                    style: TextStyle(
                                        color: thirdColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/icons/podium.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    "Rank",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: thirdColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    boardController.userRank.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: thirdColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/icons/subs.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    "Premium",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: thirdColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Text(
                                    "Subscription",
                                    style: TextStyle(
                                        color: thirdColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              )
            ]),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: 230,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Button(
              title: "Edit Profile",
              color: secondaryGreen,
              txtColor: Colors.white,
              onPressed: () => Get.to(() => CreateProfile()),
            ),
          ),
        ],
      ),
    );
  }
}
