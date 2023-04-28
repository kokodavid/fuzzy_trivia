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

  Future<void> uploadHostScores(String roomId, String hostScore) async {
    await FirebaseFirestore.instance
        .collection('gameRooms')
        .doc(roomId)
        .update({
          'scores.host':hostScore,
    });
  }

   Future<void> uploadPlayer2Scores(String roomId, String player2) async {
    await FirebaseFirestore.instance
        .collection('gameRooms')
        .doc(roomId)
        .update({
          'scores.Player2':player2
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

  String generateRandomRoomId() {
    var rng = Random();
    int min = 1000;
    int max = 9999;
    int randomNum = min + rng.nextInt(max - min);

    return randomNum.toString();
  }
}
