import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eventhub/models/event.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
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

    if (!await _checkConnectivity()) {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        snacc(context, "No Internet Connection");
      });
      return {"body": null, "statusCode": 0};
    }

    if (Image == "") {
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        snacc(context, "No Internet Connection");
      });
      return {"body": null, "statusCode": 0};
    }

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

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context);
    });
  } on SocketException catch (e) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      snacc(context, "No Internet Connection");
    });
    return {"body": null, "statusCode": 0};
  } catch (e) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      snacc(context, "An error occured. Please try again");
    });
    print('Error occured: ${e}');
    return {"body": null, "statusCode": 0};
  }

  return {"body": jsonResponse, "statusCode": 200};
}

Future<List<Event>?>? getEvents(int page) async {
  if (!await _checkConnectivity()) return null;

  List jsonResponse;

  try {
    final response = await http.get(Uri.parse(BASE_URL +
        'api/event/all?' +
        'Page=' +
        page.toString() +
        '&ItemsPerPage=2'));

    jsonResponse = jsonDecode(response.body);
    print(response.body);
    // print(jsonResponse.map((e) => Event.fromJson(e)).toList());
    return jsonResponse.map((e) => Event.fromJson(e)).toList();

    // return jsonResponse;
  } on SocketException catch (e) {
    print('Error occured: ${e.message}');
    return null;
  }
}

// Future<List<Test>?>? test() async {
//   if (!await _checkConnectivity()) return null;

//   List jsonResponse;

//   try {
//     final response =
//         await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
//     // jsonResponse = _response(response);

//     //Event.fromJson(jsonDecode(response.body));

//     jsonResponse = jsonDecode(response.body);
//     return jsonResponse.map((e) => Test.fromJson(e)).toList();

//     // return jsonResponse;
//   } on SocketException catch (e) {
//     print('Error occured: ${e.message}');
//     return null;
//   }
// }

// dynamic _response(http.Response response) {
//   switch (response.statusCode) {
//     case 200:
//       {
//         var jsonResponse = json.decode(response.body);

//         return {"body": jsonResponse, "statusCode": 200};
//       }

//     case 400:
//       {
//         //   var jsonResponse = json.decode(response.body);
//         return {
//           "body": null,
//           "statusCode": 400,
//           //"message": jsonResponse["message"]
//         };
//       }
//     case 500:
//       {
//         return {
//           "body": null,
//           "statusCode": 500,
//           //"message": jsonResponse["message"]
//         };
//       }
//     default:
//       {
//         return null;
//       }
//   }
// }

Future<String> uploadImage(File image) async {
  if (!await _checkConnectivity()) return "";
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
