class BusinessType {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  BusinessType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessType.fromJson(Map<String, dynamic> json) {
    return BusinessType(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}
