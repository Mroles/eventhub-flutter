import 'package:flutter/material.dart';

navigateToPage(int duration, BuildContext context, Widget widget) async {
  await Future.delayed(Duration(milliseconds: duration), () {});
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
