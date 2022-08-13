import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

Future<dynamic> postEvent(
    BuildContext context,
    String name,
    String date,
    String venue,
    String description,
    String Image,
    String latitude,
    String longitude,
    String userId,
    String createdAt) async {
  var jsonResponse;

  try {
    // print(BASE_URL);

    if (!await _checkConnectivity()) return {"body": null, "statusCode": 0};

    final response = await http.post(Uri.parse(BASE_URL + 'api/event/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "Name": name,
          "Date": date,
          "Venue": venue,
          "Description": description,
          "Image": Image,
          "Latitude": latitude,
          "Longitude": longitude,
          "UserId": userId,
          "CreatedAt": createdAt
        }));

    Navigator.pop(context);
  } on SocketException catch (e) {
    snacc(context, "No Internet Connection");
    return {"body": null, "statusCode": 0};
  } catch (e) {
    snacc(context, "An error occured. Please try again");
    print('Error occured: ${e}');
    return {"body": null, "statusCode": 0};
  }

  return {"body": jsonResponse, "statusCode": 200};
}

Future<dynamic> getEvents() async {
  if (!await _checkConnectivity()) return {"body": null, "statusCode": 0};

  var jsonResponse;

  try {
    final response = await http.get(Uri.parse(BASE_URL + 'api/events'));
    jsonResponse = _response(response);
  } on SocketException catch (e) {
    print('Error occured: ${e.message}');
    return {"body": null, "statusCode": 0};
  }

  return {"body": jsonResponse, "statusCode": 200};
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      {
        var jsonResponse = json.decode(response.body);

        return {"body": jsonResponse, "statusCode": 200};
      }

    case 400:
      {
        //   var jsonResponse = json.decode(response.body);
        return {
          "body": null,
          "statusCode": 400,
          //"message": jsonResponse["message"]
        };
      }
    case 500:
      {
        return {
          "body": null,
          "statusCode": 500,
          //"message": jsonResponse["message"]
        };
      }
    default:
      {
        return null;
      }
  }
}

Future<String> uploadImage(File image) async {
  var storage = FirebaseStorage.instance;

  String path = image.path;

  // final Directory systemTempDir = Directory.systemTemp;

  TaskSnapshot snapshot = await storage
      .ref("eventimages/")
      .child(DateTime.now().millisecondsSinceEpoch.toString())
      .putFile(image);

  String downloadUrl = await snapshot.ref.getDownloadURL();
  print(downloadUrl);

  return downloadUrl;
}

Future<bool> _checkConnectivity() async {
  final ConnectivityResult result = await Connectivity().checkConnectivity();

  if (result == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
