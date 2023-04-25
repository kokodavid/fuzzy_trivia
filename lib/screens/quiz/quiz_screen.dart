
import 'package:flutter/material.dart';
import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.mode, this.player, this.roomId})
      : super(key: key);

  final String? mode;
  final String? player;
  final String? roomId;

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
      body: Body(
        mode: widget.mode,
        player: widget.player,
        roomId: widget.roomId,
      ),
    );
  }
}
