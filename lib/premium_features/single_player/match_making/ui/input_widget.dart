import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    this.hint,
    required this.color,
    this.controller,
  });

  final String? hint;
  final Color color;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.all(20),
            hintText: hint,
            hintStyle: const TextStyle(color: hintColor)),
      ),
    );
  }
}
