import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  
  Future<void> createUserProfile(String userId, String username, int totalScore,
      bool isSubscribed, imageUrl) async {
    try {
      Map<String, dynamic> profileData = {
        'username': username,
        'total_score': totalScore,
        'is_subscribed': isSubscribed,
        'profile_picture_url': imageUrl
      };
      await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userId)
          .set(profileData);
    } catch (error) {
      log('Failed to create user profile: $error');
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(
      String uid) async {
    DocumentReference<Map<String, dynamic>> gameRoomRef =
        FirebaseFirestore.instance.collection('profiles').doc(uid);

    DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
        await gameRoomRef.get();

    if (profileSnapshot.exists) {
      return profileSnapshot;
    } else {
      throw Exception('Profile not found!');
    }
  }

  Future<bool> checkUsernameExists(String username) async {
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('profiles')
        .where('username', isEqualTo: username)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<void> updateScores(String uid, int score) async {
    CollectionReference gameRooms =
        FirebaseFirestore.instance.collection('profiles');

    gameRooms.doc(uid).update({
      'total_score': score,
    });
  }

  Future<String?> uploadProfilePicture(File imageFile, String userId) async {
    try {
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profile_pictures/$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      log('Failed to upload profile picture: $error');
    }
  }
}
