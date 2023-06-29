import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/friends/ui/friends_bottomsheet.dart';
import 'package:get/get.dart';

class FriendsController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  RxInt? requests;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  _init() {}

  sendRequest(String sender, String receiver) async {
    final friendsRef =
        FirebaseFirestore.instance.collection('profiles').doc(receiver);
    final snapshot = await friendsRef.get();

    final currentFriends =
        List<Map<String, dynamic>>.from(snapshot.data()?['friends'] ?? []);

    final newFriend = {'uid': sender, 'accepted': false};
    currentFriends.add(newFriend);
    await friendsRef.update({'friends': currentFriends});
  }

  friendList(String type) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('profiles')
          .doc(auth.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final friendsList = List<Map<String, dynamic>>.from(
              snapshot.data?.data()?['friends'] ?? []);

          final acceptedFriendsList = friendsList
              .where((friend) => friend['accepted'] == true)
              .toList();

          final pendingRequests = friendsList
              .where((friend) => friend['accepted'] == false)
              .toList();

          if (type != 'friends'
              ? pendingRequests.isEmpty
              : acceptedFriendsList.isEmpty) {
            return const CustomErrorWidget();
          }

          return ListView.builder(
            itemCount: type == 'friends'
                ? acceptedFriendsList.length
                : pendingRequests.length,
            itemBuilder: (BuildContext context, int index) {
              final friend = type == 'friends'
                  ? acceptedFriendsList[index]
                  : pendingRequests[index];
              final friendUid = friend['uid'];
              final accepted = friend['accepted'];

              return FutureBuilder<Map<String, dynamic>?>(
                future: getUserProfile(friendUid),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>?> profileSnapshot) {
                  if (profileSnapshot.hasData) {
                    final profileData = profileSnapshot.data;
                    final username = profileData?['username'];
                    final profilePictureUrl =
                        profileData?['profile_picture_url'];

                    return FriendsCard(
                        profilePicure: profilePictureUrl,
                        username: username,
                        type: type,
                        friendId: friendUid);
                  } else if (profileSnapshot.hasError) {
                    return Text(
                        'Error loading friend profile: ${profileSnapshot.error}',
                        style: TextStyle(color: Colors.red));
                  } else {
                    return Text("Hakuna");
                  }
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text("Hakuna");
        }
      },
    );
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final profileRef =
          FirebaseFirestore.instance.collection('profiles').doc(uid);
      final profileDoc = await profileRef.get();

      if (profileDoc.exists) {
        log(profileDoc.data().toString());
        return profileDoc.data();
      }
    } catch (e) {
      print('Error retrieving user profile: $e');
    }

    return null;
  }

  Future<void> acceptFriendRequest(String friendUid) async {
    try {
      final userRef = FirebaseFirestore.instance
          .collection('profiles')
          .doc(auth.currentUser!.uid);

      final snapshot = await userRef.get();
      final friendsList =
          List<Map<String, dynamic>>.from(snapshot.data()?['friends'] ?? []);

      final updatedFriendsList = friendsList.map((friend) {
        if (friend['uid'] == friendUid) {
          return {...friend, 'accepted': true};
        } else {
          return friend;
        }
      }).toList();

      await userRef.update({'friends': updatedFriendsList});

      await addFriendToParent(friendUid, auth.currentUser!.uid);

      print('Friend request accepted successfully.');
    } catch (e) {
      print('Error accepting friend request: $e');
    }
  }

  addFriendToParent(String sender, String receiver) async {
    final friendsRef =
        FirebaseFirestore.instance.collection('profiles').doc(sender);
    final snapshot = await friendsRef.get();

    final currentFriends =
        List<Map<String, dynamic>>.from(snapshot.data()?['friends'] ?? []);

    final newFriend = {'uid': receiver, 'accepted': true};
    currentFriends.add(newFriend);
    await friendsRef.update({'friends': currentFriends});
  }
}
