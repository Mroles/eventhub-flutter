import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../utils/constants.dart';

Future<dynamic> postEvent() async {
  var jsonResponse;

  try {
    final response =
        await http.post(Uri.parse(BASE_URL + 'api/event/create'), body: {
      "Name": "Event Name",
      "Date": "2020-01-01",
      "Venue": "Event Venue",
      "Description": "Event Description",
      "Image": "Event Image",
      "Latitude": "Event Latitude",
      "Longitude": "Event Longitude",
      "UserId": "Event UserId",
      "CreatedAt": "Event CreatedAt"
    });
  } on SocketException catch (e) {
    print('Error occured: ${e.message}');
    return {"body": null, "statusCode": 0};
  }

  return {"body": jsonResponse, "statusCode": 200};
}

Future<dynamic> getEvents() async {
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
