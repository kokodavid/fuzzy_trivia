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
            
            // Padding(
            //   padding: const EdgeInsets.only(top: kToolbarHeight),
            //   child: Form(
            //     key: _formKey,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(_authController.user.value!.displayName!),
            //         GestureDetector(
            //             onTap: () async {
            //               await profileController.pickImage(ImageSource.gallery);
            //             },
            //             child: GetBuilder<ProfileController>(
            //               init: ProfileController(),
            //               builder: (value) => CircleAvatar(
            //                 radius: 50.0,
            //                 backgroundImage: profileController.imageFile != null
            //                     ? FileImage(profileController.imageFile!)
            //                     : const AssetImage('assets/images/profile.jpeg')
            //                         as ImageProvider,
            //               ),
            //             )),
            //         TextFormField(
            //           decoration: const InputDecoration(labelText: 'Username'),
            //           validator: (value) {
            //             if (value == null || value.isEmpty) {
            //               return 'Please enter a username';
            //             }
            //             return null;
            //           },
            //           onSaved: (value) {
            //             username = value!;
            //           },
            //         ),
            //         const SizedBox(height: 16.0),
            //         ElevatedButton(
            //           onPressed: () async {
            //             if (_formKey.currentState!.validate()) {
            //               _formKey.currentState!.save();

            //               await profileController.verifyUsername(username);
            //               await profileController.uploadProfilePicture(
            //                   profileController.imageFile,
            //                   _authController.user.value!.uid);

            //               if (profileController.usernameBool == false) {
            //                 await profileController.uploadProfile(
            //                     _authController.user.value!.uid,
            //                     username,
            //                     totalScore,
            //                     isSubscribed,
            //                     profileController.profileUrl);

            //                 profileController.profileAvailable = true;

            //                 Get.to(const PremiumHome());
            //               } else {
            //                 Get.snackbar('Error', 'Username already exists',
            //                     snackPosition: SnackPosition.BOTTOM,
            //                     backgroundColor: Colors.red);
            //               }
            //             }
            //           },
            //           child: const Text('Save Profile'),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
