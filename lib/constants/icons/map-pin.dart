import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MapPinIcon extends StatelessWidget {
  final double size;
  final Color? color;
  final String? locationName;
  final Color shadowColor;
  final double shadowHeight;
  final double shadowSpread;

  const MapPinIcon({
    super.key,
    this.size = 24,
    this.color,
    this.locationName = 'TESTkjhgfdaskhjgfdsakhjgdfsjkhfsd',
    this.shadowColor = Colors.black45,
    this.shadowHeight = 4.0,
    this.shadowSpread = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset(0.3, -0.25),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // The shadow (positioned at bottom)
          Transform.translate(
            offset: Offset(0, 0), // Slight vertical offset
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: [
              // Text + TextStroke
              if (locationName != null)
                Stack(
                  children: [
                    Text(
                      locationName!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        foreground:
                            Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 4
                              ..color = Colors.white,
                      ),
                    ),
                    GradientText(
                      locationName!,
                      colors: [Color(0xFFE36658), Color(0xFFD87297)],
                      gradientDirection: GradientDirection.ltr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // foreground:
                        //     Paint()
                        //       ..style = PaintingStyle.stroke
                        //       ..strokeWidth = 0
                        //       ..color = Colors.white,
                        shadows: [
                          BoxShadow(
                            color: shadowColor,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SvgPicture.asset(
                'assets/map-pin-icon.svg',
                semanticsLabel: 'Map Pin',
                width: size,
                height: size,
                colorFilter:
                    color != null
                        ? ColorFilter.mode(color!, BlendMode.srcIn)
                        : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
