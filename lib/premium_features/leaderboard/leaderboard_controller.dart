import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuzzy_trivia/auth/controller/auth_controller.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  final AuthController authController = Get.put(AuthController());
  bool isLoading = false;
  List<DocumentSnapshot>? leaderboardList;
  int? userRank;

  buildLeaderboard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('profiles')
          .orderBy('total_score', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return const Text("No Data");
        }
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: isLoading == false
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final position = index + 1;
                      final totalScore = doc.get('total_score');
                      final name = doc.get('username');
                      final profileImage = doc.get('profile_picture_url');

                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      userRank =
                          getRanking(documents, authController.user.value!.uid);


                      if (index < 3) {
                        return Card(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            color: index == 0
                                ? polePosition
                                : index == 1
                                    ? second
                                    : third,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListTile(
                              minLeadingWidth: 10,
                              leading: Text(
                                '$position',
                                style: const TextStyle(color: Colors.black),
                              ),
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: profileImage != null
                                        ? NetworkImage(profileImage)
                                        : const NetworkImage(
                                            'https://i.pravatar.cc/150?img=1'),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(name,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ],
                              ),
                              trailing: Text('$totalScore pts.',
                                  style: const TextStyle(color: Colors.black)),
                            ));
                      } else {
                        return ListTile(
                          minLeadingWidth: 10,
                          leading: Text(
                            '$position',
                            style: const TextStyle(color: Colors.black),
                          ),
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: profileImage != null
                                    ? NetworkImage(profileImage)
                                    : const NetworkImage(
                                        'https://i.pravatar.cc/150?img=1'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(name,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                          trailing: Text('$totalScore pts.',
                              style: const TextStyle(color: Colors.black)),
                        );
                      }
                    },
                  )
                : const SpinKitWaveSpinner(
                    color: secondaryGreen,
                    waveColor: secondaryGreen,
                    size: 50,
                  ));
      },
    );
  }

  int getRanking(List<DocumentSnapshot> documents, String currentUserUid) {
    int ranking = 0;

    for (int i = 0; i < documents.length; i++) {
      if (documents[i].id == currentUserUid) {
        ranking = i + 1;
        break;
      }
    }

    return ranking;
  }
}
