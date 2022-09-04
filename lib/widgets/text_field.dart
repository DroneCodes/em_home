import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass; // to check if it is password we are inputting
  final String hintText;
  final TextInputType
  textInputType; // to decide which keyboard input type for either password or email

  const TextFieldInput(
      {Key? key,
        required this.textEditingController,
        this.isPass = false,
        required this.hintText,
        required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
    OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Container(
      color: Colors.white70,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder,
            filled: true,
            contentPadding: const EdgeInsets.all(8)),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}