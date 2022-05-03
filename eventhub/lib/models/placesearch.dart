class PlaceSearch {
  final String description;
  final String placeId;

  PlaceSearch({required this.description, required this.placeId});

  factory PlaceSearch.fromJsom(Map<String, dynamic> json) {
    return PlaceSearch(
        description: json["description"], placeId: json["place_id"]);
  }
}
