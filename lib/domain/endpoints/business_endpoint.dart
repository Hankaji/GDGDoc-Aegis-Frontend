import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/business.dart';

class BusinessApi {
  static const String _baseUrl = 'http://localhost:8080/api/businesses';

  static Future<List<Business>> getBusinesses() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((business) => Business.fromJson(business))
          .toList();
    } else {
      throw Exception('Failed to load businesses');
    }
  }

  static Future<Business> createBusiness(Business business) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'location_id': business.locationId,
        'owner_id': business.ownerId,
        'name': business.name,
        'website': business.website,
        'phone': business.phone,
        'business_type_id': business.businessTypeId,
      }),
    );
    if (response.statusCode == 201) {
      return Business.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create business');
    }
  }
}
