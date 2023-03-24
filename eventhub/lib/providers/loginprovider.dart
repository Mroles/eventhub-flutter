import 'dart:async';
import 'dart:convert';

import 'package:eventhub/models/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
import '../utils/accountcalls.dart';
import 'package:http/http.dart' as http;

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void change() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}

class LoginLoadProvider extends ChangeNotifier {
  bool isLoading = false;
  String _username = "";
  String _password = "";

  String get getUsername => _username;
  String get getPassword => _password;

  logIn(String username, String password) {
    isLoading = true;
    _username = username;
    _password = password;
    notifyListeners();

    print(isLoading);
    //int result = await logUserIn(username, password);
    final timer = Timer(const Duration(seconds: 5),
        () => {isLoading = false, print(_username), notifyListeners()});
  }
}
