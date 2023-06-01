import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuzzy_trivia/premium_features/premium_home.dart';
import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  Rx<User?> user = Rx<User?>(null);
  bool? profileAvailable;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    try {
      final currentUser = _authRepository.getCurrentUser();
      if (currentUser != null) {
        user.value = currentUser;
        log(user.value!.uid);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  checkUserData(userId) async {
    try {
      final userData = await _authRepository.checkUserProfile(userId);

      profileAvailable = userData;

      log("USERDATA===> ${profileAvailable.toString()}");

      update();
    } catch (e) {
      log("NULL==> ${e.toString()}");
    }
  }

  void signInWithGoogle() async {
    try {
      isLoading = true;
      final result = await _authRepository.signInWithGoogle();
      
      if (result != null) {
        isLoading = false;
        user.value = result.user;
        Get.to(const PremiumHome());
      } else {
        Get.snackbar('Error', 'Unable to sign in with Google.');
      }
    } catch (e) {
      log(e.toString());
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
      await _authRepository.signOut();
      user.value = null;
    } catch (e) {
      log(e.toString());
    }
  }
}
