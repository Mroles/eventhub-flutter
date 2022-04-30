import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

navigateToPage(int duration, BuildContext context, Widget widget) async {
  await Future.delayed(Duration(milliseconds: duration), () {});
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

navigateToPageLite(int duration, BuildContext context, Widget widget) async {
  await Future.delayed(Duration(milliseconds: duration), () {});
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Future<File?> pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  final imageDir = File(image.path);

  return imageDir;
}
