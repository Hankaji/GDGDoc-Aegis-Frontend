import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imgUrl;
  const Avatar(this.imgUrl, {super.key});

  @override
  Widget build(BuildContext context) {
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
}
