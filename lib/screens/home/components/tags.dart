import 'package:flutter/material.dart';
import 'package:gdgdoc/domain/models/tag.dart';

class Tags extends StatefulWidget {
  List<Tag> tagNames;

  Tags({super.key, required this.tagNames});

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  // Future<List<String>> _tagsFuture = Future.value([]); // Initialize immediately

  // void _fetchReviews() {
  //   setState(() {
  //     _reviewFuture = ReviewApi.getReviewsByLocationId(widget.locationId);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchReviews();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        children: [
          ...widget.tagNames.map(
            (tag) => Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    color: Colors.black.withValues(alpha: 0.25),
                  ),
                ],
              ),
              child: Text(tag.name),
            ),
          ),
        ],
      ),
    );
  }
}
