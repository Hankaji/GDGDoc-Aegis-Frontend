class Location {
  final String? id;
  final String? googlePlaceId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;

  Location({
    this.id,
    this.googlePlaceId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? '',
      googlePlaceId: json['google_place_id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}
