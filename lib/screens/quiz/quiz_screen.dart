
import 'package:flutter/material.dart';
import '../../premium_features/single_player/match_making/ui/premium_body.dart';
import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.mode, this.player, this.roomId,this.category,this.difficulty,this.questions})
      : super(key: key);

  final String? mode;
  final String? player;
  final String? roomId;
  final String? category;
  final String? difficulty;
  final int? questions;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          // ElevatedButton(onPressed: _controller.nextQuestion, child: Text("Skip")),
        ],
      ),
      body: widget.mode != 'premium'? Body(
        mode: widget.mode,
        player: widget.player,
        roomId: widget.roomId,
      ):PremiumBody(
        mode: widget.mode,
        player: widget.player,
        roomId: widget.roomId,
        category: widget.category,
        difficulty: widget.difficulty,
        questions: widget.questions,
      ),
    );
  }
}
