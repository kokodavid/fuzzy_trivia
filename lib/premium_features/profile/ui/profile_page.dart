import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _formKey = GlobalKey<FormState>();

  final AuthController _authController = Get.put(AuthController());

  final ProfileController profileController = Get.put(ProfileController());

  String? username = '';

  int? totalScore = 0;

  bool? isSubscribed = false;

  String? profilePictureUrl = '';

  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_authController.user.value!.displayName!),
              GestureDetector(
                  onTap: () async {
                    await profileController.pickImage(ImageSource.gallery);
                  },
                  child: GetBuilder<ProfileController>(
                    init: ProfileController(),
                    builder: (value) => CircleAvatar(
                      radius: 50.0,
                      backgroundImage: profileController.imageFile != null
                          ? FileImage(profileController.imageFile!)
                          : const AssetImage('assets/images/profile.jpeg')
                              as ImageProvider,
                    ),
                  )),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  username = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await profileController.verifyUsername(username);
                    await profileController.uploadProfilePicture(
                        profileController.imageFile,
                        _authController.user.value!.uid);

                    if (profileController.usernameBool == false) {
                      await profileController.uploadProfile(
                          _authController.user.value!.uid,
                          username,
                          totalScore,
                          isSubscribed,
                          profileController.profileUrl);

                      Get.to(const PremiumHome());
                    } else {
                      Get.snackbar('Error', 'Username already exists',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red);
                    }
                  }
                },
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
