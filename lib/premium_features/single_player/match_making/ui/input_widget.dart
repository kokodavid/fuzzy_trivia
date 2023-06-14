import 'package:flutter/material.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    this.hint,
    required this.color,
    this.controller,
    this.formKey,
  });

  final String? hint;
  final Color color;
  final Key? formKey;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Form(
        key: formKey,
        child: TextFormField(
          style: const TextStyle(color: primaryGreen),
          cursorColor: primaryGreen,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              Get.snackbar(
                'Error',
                'Please enter a value',
                backgroundColor: Colors.red,
              );

              return '';
            }
            return null; // Validation passed
          },
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
      ),
    );
  }
}
