import 'dart:convert';

import 'package:eventhub/providers/loginprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

Future<int> logUserIn(String username, String password) async {
  final response = await http.post(Uri.parse(BASE_URL + 'api/account/login'),
      body: {"Username": username, "Password": password});

  switch (response.statusCode) {
    case 200:
      {
        var token = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token[token]);
        break;
      }

    default:
      {
        break;
      }
  }

  return response.statusCode;
}
