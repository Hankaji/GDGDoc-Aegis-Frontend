import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class QuickTest extends StatelessWidget {
  const QuickTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(24), child: ReviewTab()),
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

Container avatar(String imgUrl) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          offset: Offset(0, 4),
          blurRadius: 4,
        ),
      ],
    ),
    child: CircleAvatar(backgroundImage: NetworkImage(imgUrl), radius: 18),
  );
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
        avatar(
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

Widget comment(
  String imgUrl,
  String name,
  int auras,
  int rating,
  List<Widget>? replies,
) {
  Row comment_name_info() {
    return Row(
      spacing: 4,
      children: [
        Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text("·", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text("$auras Auras", style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Row comment_rating_info() {
    return Row(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              rating.toString(),
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Transform.translate(
              offset: Offset(0, -1),
              child: Icon(
                Icons.star_rate_rounded,
                color: Color(0xFFFFB53F),
                size: 16,
              ),
            ),
          ],
        ),
        Text("·", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        Text("5 days ago", style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Row actions() {
    return Row(
      spacing: 12,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_drop_up, size: 24),
            Text("228922", style: TextStyle(fontSize: 10)),
            Icon(Icons.arrow_drop_down, size: 24),
          ],
        ),
        Row(
          children: [
            Icon(Icons.reply_rounded, size: 20),
            Text("Reply", style: TextStyle(fontSize: 10)),
          ],
        ),
        Icon(Icons.more_horiz_rounded, color: Color(0xFFCFCFCF), size: 20),
      ],
    );
  }

  // List<Widget> replies = [];

  return Row(
    spacing: 12,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      avatar(imgUrl),
      Expanded(
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [comment_name_info(), comment_rating_info()],
                ),
                Spacer(),
                Icon(
                  Icons.more_vert_rounded,
                  color: Color(0xFFCFCFCF),
                  size: 20,
                ),
              ],
            ),
            Text(
              "This place is Absolute cinema, i can never get bored going to this place.",
              style: TextStyle(fontSize: 10),
            ),
            actions(),

            if (replies != null) ...replies,
          ],
        ),
      ),
    ],
  );
}

Widget _commentSection() {
  return Column(
    children: [
      comment(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk28Z1v9WxfA6LVlxgeLy68jJfeAdScD0TUA&s',
        "HandsomeMan",
        4872,
        3,
        [
          comment(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk28Z1v9WxfA6LVlxgeLy68jJfeAdScD0TUA&s',
            "SwordSlasher2306",
            997,
            -1,
            null,
          ),
        ],
      ),
    ],
  );
}
