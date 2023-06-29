import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/friends/controller/friends_controller.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/input_widget.dart';
import 'package:get/get.dart';

import '../../../auth/controller/auth_controller.dart';
import '../../../constants.dart';
import '../../profile/controller/profie_controller.dart';
import '../../single_player/match_making/ui/button.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final ProfileController profileController = Get.put(ProfileController());
  final FriendsController friendsController = Get.put(FriendsController());
    FirebaseAuth auth = FirebaseAuth.instance;


  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final AuthController authController = Get.put(AuthController());

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
                InputWidget(
                  formKey: formKey,
                  color: inputBackground,
                  hint: 'Enter Username',
                  controller: controller,
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
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();

                                  await profileController
                                      .verifyUsername(controller.text);

                                  await friendsController.sendRequest(
                                      auth.currentUser!.uid, profileController.userId!);

                                  if (profileController.usernameBool == true) {
                                    Get.snackbar('Success', 'Request sent',
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.green);
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Username does not exist',
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.red);
                                  }
                                }
                              })),
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
