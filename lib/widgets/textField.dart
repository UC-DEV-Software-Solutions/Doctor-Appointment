import 'package:flutter/material.dart';

import '../constants/styles.dart';

class TextInputField extends StatelessWidget {

  final TextEditingController controller;
  final bool isPassword;
  final TextInputType inputKeyboardType;
  final String hintText;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.inputKeyboardType,
    required this.isPassword
}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: textInputDecorations.copyWith(hintText: hintText),
      keyboardType: inputKeyboardType,
      obscureText: isPassword,
    );
  }
}
