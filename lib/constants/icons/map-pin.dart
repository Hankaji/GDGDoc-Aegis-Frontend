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
    this.locationName = 'qwertyuiop1234567890',
    this.shadowColor = Colors.black45,
    this.shadowHeight = 4.0,
    this.shadowSpread = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(0.5, 0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Shadow (unchanged)
          Transform.translate(
            offset: const Offset(0, 0),
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
          // Pin with text box
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (locationName != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.7),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: GradientText(
                    locationName!,
                    colors: const [Color(0xFFE36658), Color(0xFFD87297)],
                    gradientDirection: GradientDirection.ltr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(height: 8), // Space between text and pin
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
