import 'dart:async';
import 'dart:convert';

import 'package:eventhub/models/login.dart';
import 'package:eventhub/models/signup.dart';
import 'package:flutter/material.dart';


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
  String _fullname = "";
  String _email = "";
  String _password = "";
  SignUpModel _signUpModel=SignUpModel(username: "", fullname: "", email: "", password: "");

  String get getUsername => _username;
  String get getPassword => _password;
  String get getFullName => _fullname;
  String get getEmail => _email;
  SignUpModel get getSignUpModel => _signUpModel;

 

  signUp(SignUpModel signUpModel) async {
    isLoading = true;
    _signUpModel = signUpModel;

    notifyListeners();

    // print(isLoading);
    int result = await signUserUp(_signUpModel);
    // final timer = Timer(const Duration(seconds: 5),
    //     () => {isLoading = false, print(_username), notifyListeners()});
    notifyListeners();
  }
}
