import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/components/avatar.dart';
import 'package:gdgdoc/screens/home/components/comment.dart';
import 'package:google_fonts/google_fonts.dart';

class RateAndReview extends StatefulWidget {
  final Function(Comment)? onCommentPosted;

  const RateAndReview({super.key, this.onCommentPosted});

  @override
  State<RateAndReview> createState() => _RateAndReviewState();
}

class _RateAndReviewState extends State<RateAndReview> {
  int _selectedRating = 0;
  final TextEditingController _textEditingCtrl = TextEditingController(
    text: "I'm thinking Teto",
  );

  final _avatarImgUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR973CvBiARVYpqXyzxOtN4ocLgBXIfEqQqph66ap8YPMOIblPqyFVnp8EbYGzsjibt7sY&usqp=CAU';

  void _postComment() {
    final comment = _textEditingCtrl.text;
    final commentWidget = Comment(
      imgUrl: _avatarImgUrl,
      name: "Teto",
      comment: comment,
      votes: 0,
      time: DateTime.now(),
      auras: 401,
      rating: _selectedRating,
    );

    widget.onCommentPosted?.call(commentWidget);
  }

  Column _text() {
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

  Row _rate() {
    return Row(
      spacing: 8,
      children: [
        Avatar(_avatarImgUrl),
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedRating = i;
              });
            },
            child: Icon(
              Icons.star_rate_rounded,
              color:
                  i <= _selectedRating ? const Color(0xFFFFB53F) : Colors.grey,
              size: 32,
            ),
          ),
      ],
    );
  }

  Column _reviewInput() {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            TextField(
              controller: _textEditingCtrl,
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
                onPressed: () => _postComment(),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_text(), _rate(), _reviewInput()],
    );
  }
}
