import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xFFE36658),
              Color(0xFFD87297),
              Color(0xFFFBCB50),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Expanded(
                child: Align(
                  child: GradientText(
                    "Ægis",
                    colors: [
                      Color(0xFF5325D4),
                      Color(0xFF5C0454),
                      Color(0xFFFF0009),
                    ],
                    gradientDirection: GradientDirection.ttb,
                    style: GoogleFonts.dmSerifText(fontSize: 64),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 64),
                    child: Text(
                      "There's a place for erveryone",
                      style: GoogleFonts.dmSerifText(
                        fontSize: 16,
                        color: Color(0xFFD9D9D9),
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
