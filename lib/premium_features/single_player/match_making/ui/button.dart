
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.color,
    required this.txtColor,
    required this.onPressed,
  });

  final String? title;
  final Color color;
  final Color txtColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(color: txtColor),
          ),
        ),
      ),
    );
  }
}