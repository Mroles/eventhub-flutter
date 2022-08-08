import 'package:eventhub/models/placesearch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  Future<List<PlaceSearch>> getAutoComplete(String search) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${search}&types=geocode&key=AIzaSyByRe5NJvtXuWMBo0a7zYkmcuGDObzkRPE";

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var jsonResults = json['predictions'] as List;

    print(jsonResults.map((place) => PlaceSearch.fromJsom(place)).toList());
    return jsonResults.map((place) => PlaceSearch.fromJsom(place)).toList();
  }
}
