import 'package:flutter/material.dart';

import '../globals.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                elevation: 0,
                backgroundColor: secondaryColorLight),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

class CustomButtonSecondary extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget widget;

  const CustomButtonSecondary({
    Key? key,
    required this.widget,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.07,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                elevation: 0,
                backgroundColor: primaryColorLight),
            onPressed: onPressed,
            child: widget),
      ),
    );
  }
}
