import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void change() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
