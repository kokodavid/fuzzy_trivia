import 'dart:developer';

import 'package:fuzzy_trivia/screens/quiz/mutiplayer/repository/multiplayer_repository.dart';
import 'package:get/get.dart';

class MultiplayerController extends GetxController {
  final MultiPlayerRepository _multiPlayerRepository = MultiPlayerRepository();

  int? rooms;

  void createNewGameRoom(String hostId) async {
    await _multiPlayerRepository.createGameRoom(hostId);
  }

  void joinGame(roomId, playerId) async {
    _multiPlayerRepository.joinGameRoom(roomId, playerId);
  }

  validateRoomId(roomId) async {
    int? result = await _multiPlayerRepository.validateRoomId(roomId);
    rooms = result;
  }

  updateGameStatus(roomId) {
    _multiPlayerRepository.updateRoomStatus(roomId);
  }
}
