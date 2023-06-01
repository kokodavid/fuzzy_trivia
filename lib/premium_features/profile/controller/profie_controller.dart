import 'dart:developer';
import 'dart:io';

import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/premium_features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final AuthController authController = AuthController();

  File? imageFile;
  bool? usernameBool;
  String? profileUrl;
  int? newScore;
  String? userName;
  int? totalScore;
  bool? profileAvailable = false;

  late final RxString _username = ''.obs;
  RxString get username => _username;

    late final RxString _picture = ''.obs;
  RxString get profilePicture => _picture;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    try {
      final currentUser = getUserData(authController.user.value!.uid);
      if (currentUser != null) {
        profileAvailable = currentUser;
        log("LOGPROF===>${profileAvailable.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }

  getUserData(userId) async {
    try {
      final userData = await _profileRepository.getUserProfile(userId);

      _username.value = userData['username'] ;
      _picture.value = userData['profile_picture_url'];
      totalScore = userData['total_score'];

      profileAvailable = true;
      update();
      log(profileAvailable.toString());
      update();

      log(userData['username']);
    } catch (e) {
      log(e.toString());
    }
  }

  updateScores(uid, int score) async {
    try {
      final currentScore = totalScore;
      log("currentScore$currentScore");
       newScore = currentScore! + score;
      log("newScore$newScore");

      await _profileRepository.updateScores(uid, newScore!);
    } catch (e) {
      log("ERAA${e.toString()}");
    }
  }

  uploadProfilePicture(imageFile, userId) async {
    try {
      profileUrl =
          await _profileRepository.uploadProfilePicture(imageFile, userId);
    } catch (e) {
      log(e.toString());
    }
  }

  verifyUsername(username) async {
    try {
      usernameBool = await _profileRepository.checkUsernameExists(username);
    } catch (e) {
      log(e.toString());
    }
  }

  uploadProfile(userId, username, totalScore, isSubscribed, imageUrl) async {
    try {
      await _profileRepository.createUserProfile(
          userId, username, totalScore, isSubscribed, imageUrl);
    } catch (e) {
      log(e.toString());
    }
  }
}
