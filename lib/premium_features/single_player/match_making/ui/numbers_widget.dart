import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuzzy_trivia/constants.dart';

class InputNumbers extends StatelessWidget {
  const InputNumbers(
      {super.key,
      this.hint,
      required this.color,
      this.controller,
      required this.formKey,
      this.validator, this.onSaved});

  final String? hint;
  final Color color;
  final Key formKey;
  final TextEditingController? controller;
  final Function? validator;
  final Function? onSaved;
  

  @override
  Widget build(BuildContext context) {

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
          onSaved: onSaved as String? Function(String?)?,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(2),
          ],
          validator: validator as String? Function(String?)?,
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
