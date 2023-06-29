import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/premium_features/mutiplayer/repository/multiplayer_repository.dart';
import 'package:get/get.dart';

class MultiplayerController extends GetxController {
  final MultiPlayerRepository _multiPlayerRepository = MultiPlayerRepository();

 Rx<int> selectedIndex = Rx<int>(-1);
  Rx<int> selectedDifIndex = Rx<int>(-1);
  TextEditingController controller = TextEditingController();

  int? rooms;
  String? status;
  String? roomId;
  bool? player;

  void selectCategoryItem(int index) {
    selectedIndex.value = index;
    log(selectedIndex.toString());
  }

   void selectDifItem(int index) {
    selectedDifIndex.value = index;
    log(selectedDifIndex.toString());
  }

  createNewGameRoom(String hostId, category, difficulty, limit) async {
    try {
      String? result = await _multiPlayerRepository.createGameRoom(
          hostId, category, difficulty, limit);
      roomId = result;
    } catch (e) {
      log(e.toString());
    }
  }

  getRoomData(roomId) async {
    DocumentSnapshot<Map<String, dynamic>> gameRoomSnapshot =
        await _multiPlayerRepository.getGameRoomData(roomId);

    Map<String, dynamic>? gameRoomData = gameRoomSnapshot.data();

    String? result = gameRoomData?['status'];
    status = result!;
    log(status.toString());
  }

  void joinGame(roomId, playerId) async {
    _multiPlayerRepository.joinGameRoom(roomId, playerId);
  }

  validateRoomId(roomId) async {
    int? result = await _multiPlayerRepository.validateRoomId(roomId);
    rooms = result;
  }

  verifyPlayer(playerId) async {
    try {
      player = await _multiPlayerRepository.checkPlayerExists(playerId);
    } catch (e) {
      log(e.toString());
    }
  }

  updateGameStatus(roomId) async {
    await _multiPlayerRepository.updateRoomStatus(roomId);
  }
}
