import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gdgdoc/screens/home/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  var control = Control.stop;
  void _transitionOut() {
    setState(() {
      control = Control.play;
    });
  }

  void _switchPage() {
    Navigator.push(
      context,
      InstantTransitionRoute(builder: (ctx) => Onboarding()),
      // platformPageRoute(
      //   context: context,
      //   builder: (context) => const Newcomer(),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   platformPageRoute(
          //     context: context,
          //     builder: (context) => const Newcomer(),
          //   ),
          // );
          _transitionOut();
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            _gradientBg(),
            _expandingCirc(control),
            _mainWidget(control, _switchPage),
          ],
        ),
      ),
    );
  }
}

Container _gradientBg() {
  return Container(
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
  );
}

Widget _expandingCirc(Control control) {
  return CustomAnimationBuilder(
    control: control,
    duration: Duration(milliseconds: 900),
    tween: Tween<double>(begin: 0, end: 24),
    curve: Curves.fastOutSlowIn,
    builder: (ctx, v, child) {
      return Transform.scale(scale: v.toDouble(), child: child);
    },
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    ),
  );
}

Center _mainWidget(Control control, Function switchPageFn) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Expanded(
          child: Align(
            child: CustomAnimationBuilder(
              onCompleted: () => switchPageFn(),
              control: control,
              tween: Tween<double>(begin: 0, end: -600),
              duration: Duration(milliseconds: 1150),
              curve: Curves.fastOutSlowIn,
              builder: (ctx, v, child) {
                return Transform.translate(
                  offset: Offset(0, v.toDouble()),
                  child: child,
                );
              },
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
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 64),
              child: CustomAnimationBuilder(
                control: control,
                tween: Tween<double>(begin: 1, end: 0),
                duration: Duration(milliseconds: 750),
                curve: Curves.fastOutSlowIn,
                builder: (ctx, v, child) {
                  return Opacity(opacity: v.toDouble(), child: child);
                },
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
        ),
      ],
    ),
  );
}

class InstantTransitionRoute extends MaterialPageRoute {
  InstantTransitionRoute({required super.builder})
    : super(maintainState: true, fullscreenDialog: false);

  @override
  Duration get transitionDuration => Duration.zero;
}
