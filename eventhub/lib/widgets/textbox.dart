import 'package:flutter/material.dart';

import '../globals.dart';

class TextBoxNoIconClass extends StatelessWidget {
  final VoidCallback onPressed;
  final String labeltext;
  final TextEditingController controller;

  const TextBoxNoIconClass(
      {Key? key,
      required this.labeltext,
      required this.onPressed,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: (tertiaryColorLight),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15.0),
            border: InputBorder.none,
            iconColor: secondaryColorLight,
            hintStyle: const TextStyle(
              color: secondaryColorLight,
            ),
            prefixIconColor: secondaryColorLight,
            labelText: labeltext,
            labelStyle: const TextStyle(color: secondaryColorLight)),
        onTap: onPressed,
      ),
    );
  }
}
