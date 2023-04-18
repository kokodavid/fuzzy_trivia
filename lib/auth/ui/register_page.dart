import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/ui/sign_in_button.dart';
import 'package:fuzzy_trivia/screens/quiz/mutiplayer/ui/multiplayer_screen.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (_authController.user.value == null) {
            return SignInWithGoogleButton();
          } else {
            return MultiPlayerScreen();
          }
        }),
      ),
    );
  }
}
