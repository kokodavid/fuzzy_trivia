import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/button.dart';
import 'package:fuzzy_trivia/premium_features/single_player/match_making/ui/input_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

import 'image_picker.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final formKey = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  final ProfileController profileController = Get.put(ProfileController());

  String? username = '';

  int? totalScore = 0;
  int selectedIndex = -1;

  bool? isSubscribed = false;

  String? profilePictureUrl = '';

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: profileBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kTextTabBarHeight * 1.5,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen),
                  ),
                ),
              ],
            ),
            ImagePickerWidget()
       
          ],
        ),
      ),
    );
  }
}
