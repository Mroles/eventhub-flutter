class Event {
  int? id;
  String? name;
  String? date;
  String? venue;
  String? description;
  String? image;
  String? latitude;
  String? longitude;
  String? userId;
  String? createdAt;

  Event(
      {this.id,
      this.name,
      this.date,
      this.venue,
      this.description,
      this.image,
      this.latitude,
      this.longitude,
      this.userId,
      this.createdAt});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    date = json['Date'];
    venue = json['Venue'];
    description = json['Description'];
    image = json['Image'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    userId = json['UserId'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Date'] = this.date;
    data['Venue'] = this.venue;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['UserId'] = this.userId;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}
