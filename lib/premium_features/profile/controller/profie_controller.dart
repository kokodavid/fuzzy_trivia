import 'dart:developer';
import 'dart:io';

import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/premium_features/profile/controller/image_picker_controller.dart';
import 'package:fuzzy_trivia/premium_features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../leaderboard/leaderboard_controller.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final AuthController authController = Get.put(AuthController());
  final LeaderboardController leaderboardController =
      Get.put(LeaderboardController());
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  File? imageFile;
  bool? usernameBool;
  String? userId;
  String? profileUrl;
  int? newScore;
  String? userName;
  int? userRank;
  int? totalScore;
  bool? profileAvailable = false;

  late final RxString _username = ''.obs;
  RxString get username => _username;

  late final RxString _picture = ''.obs;
  RxString get profilePicture => _picture;

  List<String> imageUrls = [];

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() async {
    getAvatarList();
    
    try {
      final currentUser = getUserData(authController.user.value!.uid);

      if (currentUser != null) {
        profileAvailable = currentUser;
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

      _username.value = userData['username'];
      _picture.value = userData['profile_picture_url'];
      totalScore = userData['total_score'];

      profileAvailable = true;
      update();
      log(_picture.value.toString());
      update();

      log(userData['username']);
    } catch (e) {
      log(e.toString());
    }
  }

  getAvatarList() async {
    imageUrls = await _profileRepository.getImageUrlsFromFirebaseStorage();
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

  uploadProfilePicture(userId) async {
    try {
      profileUrl = await imagePickerController.uploadProfilePicture(userId);
    } catch (e) {
      log("Profile Picture${e.toString()}");
    }
  }

  verifyUsername(username) async {
    try {
      usernameBool = await _profileRepository.checkUsernameExists(username);
      userId = _profileRepository.uid;
      log("UserId${userId.toString()}");
    } catch (e) {
      log(e.toString());
    }
  }

  uploadProfile(userId, username, totalScore, isSubscribed, imageUrl, friends,
      requests) async {
    try {
      await _profileRepository.createUserProfile(userId, username, totalScore,
          isSubscribed, imageUrl, friends, requests);
    } catch (e) {
      log(e.toString());
    }
  }

  updateProfile(userId, username) async {
    try {
      await _profileRepository.updateProfile(userId, username);
    } catch (e) {
      log(e.toString());
    }
  }
}
