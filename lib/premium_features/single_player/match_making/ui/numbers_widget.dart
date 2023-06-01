import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuzzy_trivia/constants.dart';
import 'package:get/get.dart';

class InputNumbers extends StatelessWidget {
  const InputNumbers(
      {super.key,
      this.hint,
      required this.color,
      this.controller,
      required this.formKey});

  final String? hint;
  final Color color;
  final Key formKey;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    int maxValue = 50;

    return Container(
      height: 54,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Form(
        key: formKey,
        child: TextFormField(
          keyboardType: TextInputType.number,
          style: const TextStyle(color: hintColor),
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              Get.snackbar(
                'Number of Questions',
                'Please enter a value',
                backgroundColor: Colors.red,
              );

              return '';
            }
            int? enteredValue = int.tryParse(value);
            if (enteredValue == null) {
              Get.snackbar(
                  backgroundColor: Colors.red,
                  'Number of Questions',
                  'Please enter a valid number');
              return '';
            }
            if (enteredValue > maxValue) {
              Get.snackbar(
                  'Number of Questions',
                  backgroundColor: Colors.red,
                  'Value must be less than or equal to $maxValue');
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
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(color: hintColor)),
        ),
      ),
    );
  }
}
