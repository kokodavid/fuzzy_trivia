import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/ui/sign_in_button.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:get/get.dart';

import '../../premium_features/profile/ui/profile_page.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController _authController = Get.put(AuthController());

  final ProfileController profileController = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (_authController.user.value == null) {
            return SignInWithGoogleButton();
          } else {
          // profileController.getUserData(_authController.user.value!.uid);

            return  PremiumHome();
          }
        }),
      ),
    );
  }
}
