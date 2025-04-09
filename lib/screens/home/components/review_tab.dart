import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/components/avatar.dart';
import 'package:gdgdoc/screens/home/components/comment.dart';
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

class ReviewTab extends StatelessWidget {
  const ReviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: [_starRating(), _rateAndReview(), _commentSection()],
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

Widget _rateAndReview() {
  Column text() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Rate and review',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'Let us know what you are thinking',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Row rate() {
    return Row(
      spacing: 8,
      children: [
        Avatar(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR973CvBiARVYpqXyzxOtN4ocLgBXIfEqQqph66ap8YPMOIblPqyFVnp8EbYGzsjibt7sY&usqp=CAU',
        ),
        Icon(Icons.star_rate_rounded, color: Color(0xFFFFB53F), size: 32),
        Icon(Icons.star_rate_rounded, color: Color(0xFFFFB53F), size: 32),
        Icon(Icons.star_rate_rounded, color: Color(0xFFFFB53F), size: 32),
        Icon(Icons.star_rate_rounded, color: Color(0xFFFFB53F), size: 32),
        Icon(Icons.star_rate_rounded, color: Color(0xFFFFB53F), size: 32),
      ],
    );
  }

  Column reviewInput() {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            TextField(
              controller: TextEditingController(text: "I'm thinking Teto"),
              style: TextStyle(fontSize: 12, color: Color(0xFF626262)),
              minLines: 6,
              maxLines: 10,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFEFEFEF),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: TextButton(
                onPressed: () => debugPrint('Message posted'),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF43B7F9),
                  padding: EdgeInsets.symmetric(vertical: -16, horizontal: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "3/300",
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  return Column(
    spacing: 12,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [text(), rate(), reviewInput()],
  );
}

Widget _commentSection() {
  return Column(
    children: [
      Comment(
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk28Z1v9WxfA6LVlxgeLy68jJfeAdScD0TUA&s',
        name: 'HandsomeChineseMan',
        comment:
            "This place is Absolute cinema, i can never get bored going to this place.",
        time: "5 days",
        rating: 5,
        auras: 4872,
        votes: 228922,
      ),
      Comment(
        imgUrl:
            'https://dragonball.guru/wp-content/uploads/2021/03/vegeta-profile-400x400.png',
        name: 'SwordSlasher',
        comment: "His shlong is bigger than mine.",
        time: "3 weeks",
        rating: 3,
        auras: 127,
        votes: 316791,
        replies: [
          Comment(
            imgUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnlMh-VQdsdzvvOJQPDHiQEsFGI7_pM_doLg&s',
            name: 'SwordSlasher2306',
            comment: "Skill issue",
            time: "3 weeks",
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
            time: "3 weeks",
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
        comment: "2024 anyone?",
        time: "a year",
        rating: 1,
        auras: 8,
        votes: 23,
        replies: [
          Comment(
            imgUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlv1uEukVNvXSKnZxP7yfbQt2RTqCY7hhoTA&s',
            name: 'BihAhDih',
            comment: "Shut up bro",
            time: "2 years",
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
        time: "a week",
        rating: 5,
        auras: 999999,
        votes: 702569786109124,
      ),
    ],
  );
}
