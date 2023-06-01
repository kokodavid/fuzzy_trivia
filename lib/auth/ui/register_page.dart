import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/auth/ui/sign_in_button.dart';
import 'package:fuzzy_trivia/premium_features/leaderboard/leaderboard.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _authController.user.value == null
          ? Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                child: Column(
                  children: [
                    // Center(
                    //   child: Obx(() {
                    //     if (_authController.user.value == null) {
                    //       return SignInWithGoogleButton();
                    //     } else {
                    //       log("Log Control====>${_authController.profileAvailable.toString()}");
                    //       return _authController.profileAvailable == true
                    //           ? const PremiumHome()
                    //           : CreateProfile();
                    //     }
                    //   }),
                    // ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      height: 250,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/Illustration.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color(0xffE8E8E8),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: const Text(
                              "Create an account",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: const Text(
                              "Create an account to take part in challenges,leaderboards, and more.",
                              style: TextStyle(
                                  color: Color(0xff858494), fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _authController.user.value == null
                                  ? _authController.signInWithGoogle()
                                  : const PremiumHome();
                            },
                            child: Container(
                              height: 54,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                        Image.asset("assets/icons/google.png"),
                                  ),
                                  const Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                        color: Color(0xff858494),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 54,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 15),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 1.5),
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                                child: Text(
                              'Later',
                              style: TextStyle(
                                  color: Color(0xff858494), fontSize: 17),
                            )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const PremiumHome(),
    );
  }
  
}
