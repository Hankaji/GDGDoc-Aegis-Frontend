class Tag {
  final String id;
  final String name;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  Tag({
    required this.id,
    required this.name,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      // createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      // updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}
