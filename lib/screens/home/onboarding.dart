import 'dart:ui';

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gdgdoc/screens/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // final curveType = Curves.easeOutBack;
  var curveType = Curves.easeOutQuart;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // ------------------------- Blobs -------------------------
          PlayAnimationBuilder<double>(
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 1200, end: -280),
            duration: Duration(milliseconds: 1500),
            builder: (ctx, v, _) {
              return Positioned(
                top: v.toDouble(),
                right: -250,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Blob.animatedRandom(
                    size: 800,
                    duration: Duration(seconds: 5),
                    loop: true,
                    minGrowth: 7,
                    edgesCount: 14,
                    styles: BlobStyles(color: Color(0xFFF7E1D3).withAlpha(175)),
                  ),
                ),
              );
            },
          ),
          PlayAnimationBuilder<double>(
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 1200, end: 330),
            duration: Duration(milliseconds: 1750),
            builder: (ctx, v, _) {
              return Positioned(
                top: v.toDouble(),
                right: -150,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Blob.animatedRandom(
                    size: 400,
                    duration: Duration(seconds: 7),
                    loop: true,
                    minGrowth: 9,
                    edgesCount: 5,
                    styles: BlobStyles(color: Color(0xFFDFCCF1).withAlpha(195)),
                  ),
                ),
              );
            },
          ),
          PlayAnimationBuilder<double>(
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 1200, end: 440),
            duration: Duration(milliseconds: 2150),
            builder: (ctx, v, _) {
              return Positioned(
                top: v.toDouble(),
                right: 200,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Blob.animatedRandom(
                    size: 460,
                    duration: Duration(seconds: 4),
                    loop: true,
                    minGrowth: 4,
                    edgesCount: 7,
                    styles: BlobStyles(color: Color(0xFFF5D2D3).withAlpha(195)),
                  ),
                ),
              );
            },
          ),

          // ------------------------- Main widget -------------------------
          Center(
            child: Container(
              color: Color(0x00FF0000),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PlayAnimationBuilder<double>(
                      curve: curveType,
                      tween: Tween(begin: 500, end: 0),
                      duration: Duration(milliseconds: 1150),
                      builder: (ctx, v, _) {
                        return Transform.translate(
                          offset: Offset(0, v.toDouble()),
                          child: Wrap(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 0,
                            children: [
                              Transform.translate(
                                offset: Offset(0, 32),
                                child: Text(
                                  "Let's get".toUpperCase(),

                                  style: GoogleFonts.poppins(
                                    fontSize: 80,
                                    fontWeight: FontWeight.w700,
                                  ),

                                  // style: TextStyle(
                                  //   fontSize: 64,
                                  //   fontWeight: FontWeight.w700,
                                  // ),
                                ),
                              ),
                              Text(
                                "started".toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 64,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    PlayAnimationBuilder<double>(
                      curve: curveType,
                      tween: Tween(begin: 500, end: 0),
                      duration: Duration(milliseconds: 1350),
                      builder: (ctx, v, _) {
                        return Transform.translate(
                          offset: Offset(0, v.toDouble()),
                          child: Transform.translate(
                            offset: Offset(0, -16),
                            child: Text(
                              "The best is yet to come",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    PlayAnimationBuilder<double>(
                      curve: curveType,
                      tween: Tween(begin: 500, end: 0),
                      duration: Duration(milliseconds: 1550),
                      builder: (ctx, v, _) {
                        return Transform.translate(
                          offset: Offset(0, v.toDouble()),
                          child: PlatformTextButton(
                            color: Color(0xFF383F51),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            onPressed: () {
                              Navigator.push(
                                context,
                                platformPageRoute(
                                  context: context,
                                  builder: (context) => const Login(),
                                ),
                              );
                            },
                            child: Text(
                              "Join now".toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
