import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'dart:convert';

class UserApi {
  static const String _baseUrl = 'http://localhost:8080/api/users';

  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((user) => User.fromJson(user))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<User> getUser(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': user.email,
        'password_hash': user.passwordHash,
        'role': user.role,
        'aura_points': user.auraPoints,
      }),
    );
    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }
}
