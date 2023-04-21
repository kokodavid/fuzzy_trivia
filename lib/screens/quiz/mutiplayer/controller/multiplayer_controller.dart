import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuzzy_trivia/questions/controller/question_controller.dart';
import 'package:fuzzy_trivia/screens/quiz/mutiplayer/repository/multiplayer_repository.dart';
import 'package:fuzzy_trivia/screens/quiz/quiz_screen.dart';
import 'package:get/get.dart';

class MultiplayerController extends GetxController {
  final MultiPlayerRepository _multiPlayerRepository = MultiPlayerRepository();
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _gameRoomSubscription;

  int? rooms;
  String? status;
  String? roomId;

  createNewGameRoom(String hostId) async {
    try {
      String? result = await _multiPlayerRepository.createGameRoom(hostId);
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

  readyToStartGame() async {
    await Get.put(QuestionController()).fetchQuestions();
    QuizScreen();
  }

  void joinGame(roomId, playerId) async {
    _multiPlayerRepository.joinGameRoom(roomId, playerId);
  }

  validateRoomId(roomId) async {
    int? result = await _multiPlayerRepository.validateRoomId(roomId);
    rooms = result;
  }

  updateGameStatus(roomId) async {
    await _multiPlayerRepository.updateRoomStatus(roomId);
  }
}
