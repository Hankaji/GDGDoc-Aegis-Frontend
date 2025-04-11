import 'package:gdgdoc/domain/models/tag.dart';

class Location {
  final String id;
  final String? googlePlaceId;
  final String? thumbnailImage;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<Tag>? tags;

  Location({
    required this.id,
    this.googlePlaceId,
    this.thumbnailImage,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.tags,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? '',
      googlePlaceId: json['google_place_id'] ?? '',
      thumbnailImage: json['thumbnailImage'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      tags:
          (json['tags'] as List<dynamic>).map((s) {
            return Tag(id: s['id'], name: s['name']);
          }).toList(),
    );
  }
}
