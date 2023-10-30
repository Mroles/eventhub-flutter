import 'dart:convert';
import 'package:eventhub/models/signup.dart';
import 'package:http/http.dart' as http;
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
        await prefs.setString("token", token["token"]);
        await prefs.setString("username", token["username"]);
        break;
      }

    default:
      {
        break;
      }
  }

  return response.statusCode;
}

Future<int> signUserUp(SignUpModel signUpModel) async {
  final response = await http.post(Uri.parse(BASE_URL + 'api/account/register'),
      body: signUpModel);

  switch (response.statusCode) {
    case 200:
      {
        break;
      }
    default:
      {
        break;
      }
  }
  return response.statusCode;
}
