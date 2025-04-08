import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapPinIcon extends StatelessWidget {
  final double size;
  final Color? color;
  final Color shadowColor;
  final double shadowHeight;
  final double shadowSpread;

  const MapPinIcon({
    super.key,
    this.size = 24,
    this.color,
    this.shadowColor = Colors.black45,
    this.shadowHeight = 4.0,
    this.shadowSpread = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // The shadow (positioned at bottom) 
        Transform.translate(
          offset: Offset(0,0), // Slight vertical offset
          child: Container(
            width: size * shadowSpread,
            height: size * 0.1,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(size),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: size * 0.2,
                  spreadRadius: size * 0.1,
                ),
              ],
            ),
          ),
        ),
        // The actual pin icon
        SvgPicture.asset(
          'assets/map-pin-icon.svg',
          semanticsLabel: 'Map Pin',
          width: size,
          height: size,
          colorFilter: color != null 
              ? ColorFilter.mode(color!, BlendMode.srcIn)
              : null,
        ),
      ],
    );
  }
}
