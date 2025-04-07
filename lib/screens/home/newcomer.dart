import 'dart:ui';

import 'package:blobs/blobs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Newcomer extends StatefulWidget {
  const Newcomer({super.key});

  @override
  State<Newcomer> createState() => _NewcomerState();
}

class _NewcomerState extends State<Newcomer> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      // body: Container(
      //   child: Blob.animatedRandom(
      //     size: 200,
      //     duration: Duration(seconds: 1),
      //     loop: true,
      //     controller: blobCtrl,
      //     minGrowth: 7,
      //     edgesCount: 8,
      //     styles: BlobStyles(color: Color(0xFFF7E1D3)),
      //   ),
      // ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // Blobs
          // Container(
          Positioned(
            top: -280,
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
          ),
          Positioned(
            top: 330,
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
          ),
          Positioned(
            top: 440,
            right: 180,
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
          ),
          // ),

          // Positioned(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(100),
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          //       child: Container(
          //         width: 200,
          //         height: 200,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Color(0xFFF7E1D3),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Main widgets
          Center(
            child: Container(
              color: Color(0x00FF0000),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Let's get".toUpperCase(),
                      style: TextStyle(
                        fontSize: 64,
                        height: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "started".toUpperCase(),
                      style: TextStyle(
                        fontSize: 64,
                        height: 0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      "The best is yet to come",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 24),
                    PlatformTextButton(
                      color: Color(0xFF383F51),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      onPressed: () {}, // TODO: Move to register
                      child: Text(
                        "Join now".toUpperCase(),
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
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
