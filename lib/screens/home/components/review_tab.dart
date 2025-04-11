import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/components/comment.dart';
import 'package:gdgdoc/domain/models/review.dart';
import 'package:gdgdoc/domain/endpoints/review_endpoint.dart';
import 'package:gdgdoc/screens/home/components/rate_and_review.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

// class QuickTest extends StatelessWidget {
//   const QuickTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(padding: EdgeInsets.all(24), child: ReviewTab(locationId: )),
//       ),
//     );
//   }
// }

class ReviewTab extends StatefulWidget {
  final String locationId;
  const ReviewTab({super.key, required this.locationId});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  Future<List<Review>> _reviewFuture = Future.value(
    [],
  ); // Initialize immediately

  @override
  void initState() {
    super.initState();
    if (widget.locationId.isNotEmpty) {
      _reviewFuture = ReviewApi.getReviewsByLocationId(widget.locationId);
    }
  }

  void _analyzeComment(List<Review> reviews) {
    debugPrint("PLACEHOLDER: Send these reviews to backend for auto tagging");

    List<Map<String, dynamic>> reviewData =
        reviews
            .map(
              (r) => {
                'author_name': 'Pepepopo',
                'rating': r.rating,
                'text': r.comment,
                'time': r.createdAt!.millisecondsSinceEpoch,
              },
            )
            .toList();

    String jsonString = jsonEncode(reviewData);
    debugPrint(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.locationId.isEmpty) {
      return const Center(child: Text('No location selected'));
    }

    return FutureBuilder<List<Review>>(
      future: _reviewFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No reviews yet'));
        }

        return _buildReviewList(snapshot.data!);
      },
    );
  }

  Widget _buildReviewList(List<Review> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        _starRating(),
        RateAndReview(
          onCommentPosted: (newComment) {
            // You'll need to adapt this to work with Review objects
            // Or keep using Comment objects and convert between them
          },
        ),
        ...reviews.map((review) => _buildReviewItem(review)).toList(),
        TextButton(
          onPressed: () => _analyzeComment(reviews),
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: -16, horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Analyze comment",
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Review review) {
    return Comment(
      imgUrl:
          'https://static.wikia.nocookie.net/balatrogame/images/1/13/Cavendish.png/revision/latest?cb=20240320232317', // Default image
      name: 'Pepepopo',
      comment: review.comment ?? '',
      votes: Random().nextInt(10000000),
      time: review.createdAt ?? DateTime(2025, 1, 2, 3, 4),
      auras: Random().nextInt(10000000),
      rating: review.rating ?? 0,
      replies: [
        Comment(
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlv1uEukVNvXSKnZxP7yfbQt2RTqCY7hhoTA&s',
          name: 'BihAhDih',
          comment: "Shut up bro",
          time: DateTime.now(),
          isReply: true,
          rating: -1,
          auras: 156,
          votes: -210,
        ),
      ],
    );
  }
}

Widget _starRating() {
  Column currRating() {
    return Column(
      children: [
        Text(
          '4.8',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('(9K)', style: TextStyle(fontSize: 10)),
        Icon(Icons.star_rate_rounded, color: Colors.yellow),
      ],
    );
  }

  Expanded ratingCount() {
    Widget ratingBar(double value) {
      return SizedBox(
        height: 12,
        child: LinearPercentIndicator(
          lineHeight: 6,
          percent: value,
          barRadius: Radius.circular(24),
          backgroundColor: Colors.white70,
          progressColor: Colors.yellow,
        ),
      );
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ratingBar(0.96),
          ratingBar(0.35),
          ratingBar(0.1),
          ratingBar(0.02),
          ratingBar(0.035),
        ],
      ),
    );
  }

  return IntrinsicHeight(child: Row(children: [currRating(), ratingCount()]));
}
