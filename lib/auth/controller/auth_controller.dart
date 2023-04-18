import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
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
      }
    } catch (e) {
      print(e);
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
      print(e);
      Get.snackbar('Error', 'Unable to sign in with Google.');
    }
  }

  void signOut() async {
    try {
      await _authRepository.signOut();
      user.value = null;
    } catch (e) {
      print(e);
    }
  }
}