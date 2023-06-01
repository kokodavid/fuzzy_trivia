import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/ui/register_page.dart';
import 'package:fuzzy_trivia/screens/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  RegisterPage()),
      );
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