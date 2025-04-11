class User {
  final String id;
  final String email;
  final String passwordHash;
  final String role;
  final double auraPoints;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.role,
    required this.auraPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      passwordHash: json['password_hash'],
      role: json['role'],
      auraPoints: json['aura_points']?.toDouble(),
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}
