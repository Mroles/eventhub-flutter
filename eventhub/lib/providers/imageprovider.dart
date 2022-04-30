import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProv with ChangeNotifier {
  File? imageDir;

  Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    final imageDir = File(image.path);
    print(imageDir);
    notifyListeners();

    return imageDir;
  }
}
