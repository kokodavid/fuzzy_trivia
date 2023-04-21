import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MultiPlayerRepository {
  Future<String?> createGameRoom(String hostId) async {
    String roomId = generateRandomRoomId();

    Map<String, dynamic> players = {"HostId": hostId, "Player2": ""};
    Map<String, dynamic> scores = {"host": "0", "Player2": "0"};


    await FirebaseFirestore.instance.collection('gameRooms').doc(roomId).set({
      'room_Id': roomId,
      'hostId': hostId,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'waiting',
      'players': players,
      'turn':hostId,
      'scores':scores

    });

    return roomId;
  }

  Future<void> joinGameRoom(String roomId, String playerId) async {
    await FirebaseFirestore.instance
        .collection('gameRooms')
        .doc(roomId)
        .update({
      'players.Player2': playerId,
    });
  }

  Future<void> updateRoomStatus(String roomId) async {
    CollectionReference gameRooms =
        FirebaseFirestore.instance.collection('gameRooms');

    gameRooms.doc(roomId).update({
      'status': 'ready',
    });
  }

  Future<int?> validateRoomId(String roomId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('gameRooms')
        .where('room_Id', isEqualTo: roomId)
        .get();

    return snapshot.docs.length;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getGameRoomData(
      String roomId) async {
    DocumentReference<Map<String, dynamic>> gameRoomRef =
        FirebaseFirestore.instance.collection('gameRooms').doc(roomId);

    DocumentSnapshot<Map<String, dynamic>> gameRoomSnapshot =
        await gameRoomRef.get();

    if (gameRoomSnapshot.exists) {
      return gameRoomSnapshot;
    } else {
      throw Exception('Game room not found!');
    }
  }

  Future<void> uploadScores(String playerName, int score) async {
    try {
      CollectionReference scoresCollection =
          FirebaseFirestore.instance.collection('scores');

      DocumentReference newScoreDocRef = scoresCollection.doc();

      Map<String, dynamic> newScoreDoc = {
        'playerName': playerName,
        'score': score,
      };

      await newScoreDocRef.set(newScoreDoc);

      print('Score uploaded successfully!');
    } catch (e) {
      print('Error uploading score: $e');
    }
  }

  String generateRandomRoomId() {
    var rng = Random();
    int min = 1000;
    int max = 9999;
    int randomNum = min + rng.nextInt(max - min);

    return randomNum.toString();
  }
}
