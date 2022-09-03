import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String formatDate(String date) {
  DateTime parseDate = DateFormat("MM/dd/yyyy").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());

  var outputFormat = DateFormat.yMMMEd();
  String outputDate = outputFormat.format(inputDate);

  return outputDate;
}

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
