class LocationTag {
  final String id;
  final String locationId;
  final String tagId;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  LocationTag({
    required this.id,
    required this.locationId,
    required this.tagId,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LocationTag.fromJson(Map<String, dynamic> json) {
    return LocationTag(
      id: json['id'],
      locationId: json['location_id'],
      tagId: json['tag_id'],
      address: json['address'],
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}
