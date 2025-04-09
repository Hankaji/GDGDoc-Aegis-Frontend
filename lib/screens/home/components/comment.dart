import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/components/avatar.dart';

class Comment extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String comment;
  final int votes;
  final String time;
  final int auras;
  final int rating;
  final List<Comment>? replies;
  final bool isReply;

  const Comment({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.comment,
    required this.votes,
    required this.time,
    required this.auras,
    required this.rating,
    this.replies,
    this.isReply = false,
  });

  Widget _commentNameInfo() {
    return Row(
      spacing: 4,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const Text(
          "·",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text("$auras Auras", style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _commentRatingInfo() {
    return Row(
      spacing: 4,
      children: [
        if (!isReply)
          Row(
            children: [
              Text(
                rating.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -1),
                child: const Icon(
                  Icons.star_rate_rounded,
                  color: Color(0xFFFFB53F),
                  size: 16,
                ),
              ),
            ],
          ),
        if (!isReply)
          const Text(
            "·",
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        Text("$time ago", style: TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _actions() {
    return Row(
      spacing: 12,
      children: [
        Row(
          spacing: 2,
          children: [
            const Icon(Icons.arrow_drop_up, size: 24),
            Text(votes.toString(), style: TextStyle(fontSize: 10)),
            const Icon(Icons.arrow_drop_down, size: 24),
          ],
        ),
        if (!isReply)
          Row(
            spacing: 4,
            children: const [
              Icon(Icons.reply_rounded, size: 20),
              Text("Reply", style: TextStyle(fontSize: 10)),
            ],
          ),
        const Icon(
          Icons.more_horiz_rounded,
          color: Color(0xFFCFCFCF),
          size: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(imgUrl),
        Expanded(
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_commentNameInfo(), _commentRatingInfo()],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_vert_rounded,
                    color: Color(0xFFCFCFCF),
                    size: 20,
                  ),
                ],
              ),
              Text(comment, style: TextStyle(fontSize: 10)),
              _actions(),
              if (replies != null) ...replies!,
            ],
          ),
        ),
      ],
    );
  }
}
