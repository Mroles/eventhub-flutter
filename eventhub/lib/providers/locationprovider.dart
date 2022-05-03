import 'package:eventhub/models/location.dart';
import 'package:eventhub/models/placesearch.dart';
import 'package:eventhub/utils/placeservice.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  final LocationModel _locationModel =
      LocationModel(latitude: 0.0, longitude: 0.0);

  final placesService = PlacesService();
  List<PlaceSearch> searchResults = [];

  LocationModel get locationModel => _locationModel;

  void storeLocation(double longitude, double latitude) {
    _locationModel.latitude = latitude;
    _locationModel.longitude = longitude;

    notifyListeners();
  }

  searchPlaces(String search) async {
    searchResults = await placesService.getAutoComplete(search);
    notifyListeners();
  }
}
