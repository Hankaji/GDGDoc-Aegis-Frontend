import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/business_type.dart';

class BusinessTypeApi {
  static const String _baseUrl = 'http://localhost:8080/api/business-types';

  static Future<List<BusinessType>> getBusinessTypes() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((businessType) => BusinessType.fromJson(businessType))
          .toList();
    } else {
      throw Exception('Failed to load business types');
    }
  }

  static Future<BusinessType> createBusinessType(
    BusinessType businessType,
  ) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': businessType.name}),
    );
    if (response.statusCode == 201) {
      return BusinessType.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create business type');
    }
  }
}
