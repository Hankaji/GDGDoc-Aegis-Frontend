import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/components/avatar.dart';
import 'package:gdgdoc/screens/home/components/comment.dart';
import 'package:gdgdoc/screens/home/components/comment_section.dart';
import 'package:gdgdoc/screens/home/components/rate_and_review.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class QuickTest extends StatelessWidget {
  const QuickTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(24), child: ReviewTab()),
      ),
    );
  }
}

class ReviewTab extends StatefulWidget {
  const ReviewTab({super.key});

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab> {
  List<Comment> comments = [
    Comment(
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk28Z1v9WxfA6LVlxgeLy68jJfeAdScD0TUA&s',
      name: 'HandsomeChineseMan',
      comment:
          "This place is Absolute cinema, i can never get bored going to this place.",
      time: DateTime(2025, 4, 10, 19, 55),
      rating: 5,
      auras: 4872,
      votes: 228922,
    ),
    Comment(
      imgUrl:
          'https://dragonball.guru/wp-content/uploads/2021/03/vegeta-profile-400x400.png',
      name: 'SwordSlasher',
      comment: "His shlong is bigger than mine, would come again 3/5.",
      time: DateTime(2025, 4, 10, 19, 56),
      rating: 3,
      auras: 127,
      votes: 316791,
      replies: [
        Comment(
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnlMh-VQdsdzvvOJQPDHiQEsFGI7_pM_doLg&s',
          name: 'SwordSlasher2306',
          comment: "Skill issue",
          time: DateTime(2025, 4, 10, 19, 56),
          isReply: true,
          rating: 3,
          auras: 997,
          votes: 1864,
        ),
        Comment(
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlv1uEukVNvXSKnZxP7yfbQt2RTqCY7hhoTA&s',
          name: 'BihAhDih',
          comment: "Ur jealous lol",
          time: DateTime(2025, 4, 10, 19, 56),
          isReply: true,
          rating: 3,
          auras: 156,
          votes: 78,
        ),
      ],
    ),
    Comment(
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-7GrrTHrY7rCTNuz97ZoGTX3W-ZNCMsZxow&s',
      name: 'Creeper2012',
      comment: "This place isn't that good guys they lied to you.",
      time: DateTime(2024, 4, 10, 19, 56, 0),
      rating: 1,
      auras: 8,
      votes: 23,
      replies: [
        Comment(
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlv1uEukVNvXSKnZxP7yfbQt2RTqCY7hhoTA&s',
          name: 'BihAhDih',
          comment: "Shut up bro",
          time: DateTime(2023, 4, 10, 19, 56, 0),
          isReply: true,
          rating: -1,
          auras: 156,
          votes: -210,
        ),
      ],
    ),
    Comment(
      imgUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpmNskM4AGEpg1iIVAQ_n9nF_KaHJjgiuHiA&s',
      name: 'RealGoku',
      comment: "It's fun being here.",
      time: DateTime(2025, 4, 10, 19, 56, 0),
      rating: 5,
      auras: 999999,
      votes: 702569786109124,
    ),
  ];

  void _analyzeComment() {
    debugPrint("PLACEHOLDER: Send these comments to backend for auto tagging");

    List<Map<String, dynamic>> reviews =
        comments
            .map(
              (c) => {
                'author_name': c.name,
                'rating': c.rating,
                'text': c.comment,
                'time': c.time.millisecondsSinceEpoch,
              },
            )
            .toList();

    String jsonString = jsonEncode(reviews);
    debugPrint(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [
        _starRating(),
        RateAndReview(
          onCommentPosted:
              (newComment) => setState(() {
                comments.add(newComment);
              }),
        ),
        CommentSection(comments),
        // WARNING: Placeholder button to demonstrate the auto-tagging feature
        // TODO: Delete this
        TextButton(
          onPressed: () => _analyzeComment(),
          style: TextButton.styleFrom(
            backgroundColor: Color(0xFFFF4B23),
            padding: EdgeInsets.symmetric(vertical: -16, horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
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
        Icon(Icons.star_rate_rounded, color: Color(0xFFFFB53F)),
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
          backgroundColor: Color(0xFFEAEAEA),
          progressColor: Color(0xFFFFB53F),
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
