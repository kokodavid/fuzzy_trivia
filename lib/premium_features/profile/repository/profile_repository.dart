import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepository {
  Future<void> createUserProfile(String userId, String username, int totalScore,
      bool isSubscribed, imageUrl, List<String> friends,List<String> requests) async {
    try {
      
      Map<String, dynamic> profileData = {
        'username': username,
        'total_score': totalScore,
        'is_subscribed': isSubscribed,
        'profile_picture_url': imageUrl,
        'friends': friends,
        'requests': requests,
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

  Future<bool> hasProfile(String uid) async {
    try {
      final profileSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(uid)
          .get();
      return profileSnapshot.exists;
    } catch (e) {
      log('Error checking user profile: $e');
      return false;
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

  Future<void> updateProfile(String uid, String username) async {
    CollectionReference profile =
        FirebaseFirestore.instance.collection('profiles');

    profile.doc(uid).update({
      'username': username,
    });
  }

  Future<List<String>> getImageUrlsFromFirebaseStorage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    ListResult result = await storage.ref('avatars/').listAll();
    List<String> imageUrls = [];

    for (var imageRef in result.items) {
      String imageUrl = await imageRef.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    return imageUrls;
  }
}
