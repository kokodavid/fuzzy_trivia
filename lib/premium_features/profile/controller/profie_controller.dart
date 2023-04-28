import 'dart:developer';
import 'dart:io';

import 'package:fuzzy_trivia/premium_features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();

  File? imageFile;
  bool? usernameBool;
  String? profileUrl;
  String? userName;
  String? profilePicture;
  int? totalScore;

  pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }

  getUserData(userId) async {
    final userData = await _profileRepository.getUserProfile(userId);

    userName = userData['username'];
    profilePicture = userData['profile_picture_url'];
    totalScore = userData['total_score'];

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
