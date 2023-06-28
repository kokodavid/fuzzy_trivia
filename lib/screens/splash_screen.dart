import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/ui/register_page.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:get/get.dart';

import '../auth/controller/auth_controller.dart';
import '../premium_features/profile/controller/profie_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());

  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      authController.user.value == null 
          ? Get.to(() =>  const RegisterPage())
          : Get.to(() => const PremiumHome());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff04CC7B),
      body: Center(
        child: Image.asset(
          'assets/icons/splashlogo.png',
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
