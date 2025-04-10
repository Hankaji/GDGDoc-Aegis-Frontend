import 'package:flutter/widgets.dart';
import 'package:gdgdoc/screens/home/components/comment.dart';

class CommentSection extends StatelessWidget {
  final List<Comment> comments;

  const CommentSection(List<Comment>? comments, {super.key})
    : comments = comments ?? const [];

  @override
  Widget build(BuildContext context) {
    return Column(children: comments);
  }
}
