import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String _baseUrl = 'http://10.0.2.2:8080/api'; // Android emulator
  static const String _baseUrl = 'http://localhost:8080/api'; // iOS simulator
  // static const String _baseUrl = 'http://your-local-ip:8080'; // Physical device

  static Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
