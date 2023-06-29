import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class SignInWithGoogleButton extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

   SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _authController.signInWithGoogle();
      },
      icon: const Icon(Icons.g_mobiledata_rounded),
      label: const Text(
        'Sign In With Google',
      ),
    );
  }
}