import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

navigateToPageLite(
    int duration, BuildContext context, Widget widget, Function? func) async {
  await Future.delayed(Duration(milliseconds: duration), () {});
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget))
      .then((value) => func);
}

Future<File?> pickImage() async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  final imageDir = File(image.path);

  return imageDir;
}

Future<bool> checkLogin() async {
  var prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString("token");
  final String? username = prefs.getString("username");

  if (token!.isEmpty || username!.isEmpty) return false;

  return true;
}
