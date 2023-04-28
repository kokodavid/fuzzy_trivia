import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/profie_controller.dart';
import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final ProfileController _profileController = ProfileController();
  Rx<User?> user = Rx<User?>(null);

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
        _profileController.getUserData(user.value!.uid);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void signInWithGoogle() async {
    try {
      final result = await _authRepository.signInWithGoogle();
      if (result != null) {
        user.value = result.user;
      } else {
        Get.snackbar('Error', 'Unable to sign in with Google.');
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', 'Unable to sign in with Google.');
    }
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
