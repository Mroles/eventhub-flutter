import 'package:flutter/material.dart';

import '../globals.dart';

class DateField extends StatelessWidget {
  final VoidCallback onPressed;
  final String labelText;

  final TextEditingController controller;

  const DateField(
      {Key? key,
      required this.onPressed,
      required this.labelText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: (tertiaryColorLight),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 15.0),
            border: InputBorder.none,
            iconColor: secondaryColorLight,
            hintStyle: const TextStyle(
              color: primaryColorLight,
            ),
            prefixIconColor: secondaryColorLight,
            labelText: labelText,
            labelStyle: const TextStyle(color: secondaryColorLight)),
        controller: controller,
        readOnly: true,
        onTap: onPressed,
      ),
    );
  }
}
