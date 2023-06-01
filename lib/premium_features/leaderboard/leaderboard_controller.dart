import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

class LeaderboardController extends GetxController {
  String svgCode = RandomAvatarString('saytoonz');
  bool isLoading = false;

  buildLeaderboard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('profiles')
          .orderBy('total_score', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          isLoading = true;
          log(isLoading.toString());
        } else {
          isLoading = false;
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
}
