import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';
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

  Future<int> logUserIn(String username, String password) async {
    isLoading = true;
    final response = await http.post(Uri.parse(BASE_URL + 'api/account/login'),
        body: {"Username": username, "Password": password});

    switch (response.statusCode) {
      case 200:
        {
          var token = jsonDecode(response.body);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token["token"]);
          await prefs.setString("username", token["username"]);
          break;
        }

      default:
        {
          break;
        }
    }
    isLoading = false;
    return response.statusCode;
  }
}
