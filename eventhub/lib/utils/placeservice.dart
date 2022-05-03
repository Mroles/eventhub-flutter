import 'package:eventhub/models/placesearch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${search}&types=geocode&key=AIzaSyBdm5eTykTEd9QeK0Mar820-C8h4w_29Ps";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var jsonResults = json['predictions'] as List;

    print(jsonResults.map((place) => PlaceSearch.fromJsom(place)).toList());
    return jsonResults.map((place) => PlaceSearch.fromJsom(place)).toList();
  }
}
