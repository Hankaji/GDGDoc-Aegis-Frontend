class Business {
  final String id;
  final String? locationId;
  final String? ownerId;
  final String name;
  final String? website;
  final String? phone;
  final String businessTypeId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Business({
    required this.id,
    this.locationId,
    this.ownerId,
    required this.name,
    this.website,
    this.phone,
    required this.businessTypeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      locationId: json['location_id'],
      ownerId: json['owner_id'],
      name: json['name'],
      website: json['website'],
      phone: json['phone'],
      businessTypeId: json['business_type_id'],
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}
