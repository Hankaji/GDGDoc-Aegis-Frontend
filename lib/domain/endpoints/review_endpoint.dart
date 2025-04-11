import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/review.dart';

class ReviewApi {
  static const String _baseUrl = 'http://localhost:8080/api/reviews';

  static Future<List<Review>> getReviewsByLocationId(String locationId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/by-location/$locationId'),
    );
    if (response.statusCode == 200) {
      // Decode the raw bytes to ensure UTF-8 handling
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = json.decode(decodedBody);

      return jsonData.map((review) => Review.fromJson(review)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  static Future<double> getAvgRatingByLocationId(String locationId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/locations/$locationId/average-rating'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Handle cases where averageRating might be null or not a number
        if (responseData['averageRating'] == null) {
          return 0.0; // Default value when no ratings exist
        }

        // Handle both integer and double responses
        return (responseData['averageRating'] as num).toDouble();
      } else {
        throw Exception(
          'Failed to load average rating: ${response.statusCode}',
        );
      }
    } on FormatException catch (e) {
      throw Exception('Invalid response format: $e');
    } on http.ClientException catch (e) {
      throw Exception('Network error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  static Future<Review> createReview(Review review) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'locationId': review.locationId,
        'userId': review.userId,
        'rating': review.rating,
        'comment': review.comment,
      }),
    );
    if (response.statusCode == 201) {
      return Review.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create review');
    }
  }
}
