import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:fuzzy_trivia/premium_features/profile/ui/create_profile.dart';
import 'package:get/get.dart';

import '../../premium_features/profile/repository/profile_repository.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final ProfileRepository profileRepository = ProfileRepository();
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);
  bool? profileAvailable;
  bool isLoading = false;
  bool? hasProfile;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    try {
      final currentUser = authRepository.getCurrentUser();
      authRepository.checkUserProfile(auth.currentUser!.uid);
      if (currentUser != null) {
        user.value = currentUser;
        log(user.value!.uid);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // checkUserData(userId) async {
  //   try {
  //     final userData = await authRepository.checkUserProfile(userId);

  //     profileAvailable = userData;

  //     log("USERDATA===> ${profileAvailable.toString()}");

  //     update();
  //   } catch (e) {
  //     log("NULL==> ${e.toString()}");
  //   }
  // }

  void signInWithGoogle() async {
    try {
      isLoading = true;
      final result = await authRepository.signInWithGoogle();

      if (result != null) {
        user.value = result.user;

        // profileAvailable =
        //     await authRepository.checkUserProfile(auth.currentUser!.uid);

        if (profileAvailable == true) {
          Get.to(() => const PremiumHome());
        } else {
          Get.to(() => const CreateProfilePage());
        }
      }
    } catch (e, c) {
      log('$e ${c.toString()}');
      Get.snackbar('Error', 'Unable to sign in with Google.');
    }
  }

  loader() {
    return const SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    );
  }

  void signOut() async {
    try {
      await authRepository.signOut();
      user.value = null;
    } catch (e) {
      log(e.toString());
    }
  }
}
