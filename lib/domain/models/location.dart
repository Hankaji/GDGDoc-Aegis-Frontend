class Location {
  final String? id;
  final String? googlePlaceId;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Location({
    this.id,
    this.googlePlaceId,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? '',
      googlePlaceId: json['google_place_id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
