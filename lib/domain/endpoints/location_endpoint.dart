import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location.dart';

class LocationApi {
  static const String _baseUrl = 'http://localhost:8080/api/locations';

  static Future<List<Location>> getLocations() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      // Decode the raw bytes to ensure UTF-8 handling
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = json.decode(decodedBody);

      return jsonData.map((location) => Location.fromJson(location)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future<Location> createLocation(Location location) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'google_place_id': location.googlePlaceId,
        'name': location.name,
        'address': location.address,
        'latitude': location.latitude,
        'longitude': location.longitude,
      }),
    );
    if (response.statusCode == 201) {
      return Location.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create location');
    }
  }
}
