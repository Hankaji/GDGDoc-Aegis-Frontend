import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_tag.dart';
import '../models/tag.dart';
import '../models/location.dart';

class LocationTagApi {
  static const String _baseUrl = 'http://localhost:8080/api/location-tags';

  static Future<List<LocationTag>> getLocationTags() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((locationTag) => LocationTag.fromJson(locationTag))
          .toList();
    } else {
      throw Exception('Failed to load location tags');
    }
  }

  static Future<List<Tag>> getTagsByLocationId(String locationId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/tags-by-location/$locationId'),
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tag) => Tag.fromJson(tag))
          .toList();
    } else {
      throw Exception('Failed to load location tags');
    }
  }

  static Future<List<Location>> getLocationByTagId(String tagId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/locations-by-tag/$tagId'),
    );
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((location) => Location.fromJson(location))
          .toList();
    } else {
      throw Exception('Failed to load location tags');
    }
  }

  static Future<LocationTag> createLocationTag(LocationTag locationTag) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'location_id': locationTag.locationId,
        'tag_id': locationTag.tagId,
        'address': locationTag.address,
      }),
    );
    if (response.statusCode == 201) {
      return LocationTag.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create location tag');
    }
  }
}
