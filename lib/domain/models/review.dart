class Review {
  final String? id;
  final String? locationId;
  final String? userId;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Review({
    this.id,
    this.locationId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      locationId: json['locationId'],
      userId: json['userId'],
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']) ?? DateTime.now(),
    );
  }
}
