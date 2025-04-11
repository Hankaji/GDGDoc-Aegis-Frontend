import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tag.dart';

class TagApi {
  static const String _baseUrl = 'http://localhost:8080/api/tags';

  static Future<List<Tag>> getTags() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tag) => Tag.fromJson(tag))
          .toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }

  static Future<Tag> getTagById(String tagId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$tagId'));
    if (response.statusCode == 200) {
      return Tag.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load tags');
    }
  }

  static Future<Tag> createTag(Tag tag) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': tag.name}),
    );
    if (response.statusCode == 201) {
      return Tag.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create tag');
    }
  }
}
