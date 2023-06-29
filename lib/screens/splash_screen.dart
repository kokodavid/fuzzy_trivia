import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/ui/register_page.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:get/get.dart';

import '../auth/controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      auth.currentUser == null
          ? Get.to(() => const RegisterPage())
          : Get.to(() => const PremiumHome());
    });
  }

  @override
  Widget build(BuildContext context) {
    log(auth.currentUser.toString());
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
