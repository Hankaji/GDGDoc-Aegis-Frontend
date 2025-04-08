import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                ..._welcomeText(),
                _inputs(),
                SizedBox(height: 32), // TODO: Change according to screen size?
                ..._alternativeLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _inputs() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Column(
      spacing: 32,
      children: [
        // Inputs
        Column(
          spacing: 12,
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF1F4FF),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Email",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF626262),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF1F4FF),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF626262),
                ),
              ),
            ),
          ],
        ),
        // Action button
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFCBD6FF),
                offset: Offset(0, 8),
                blurRadius: 16,
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            clipBehavior: Clip.none,
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6E71F5),
                    Color(0xFF6E178B),
                    Color(0xFF7C418F),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => debugPrint("Change to map page"),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Already have an account text
        Text(
          "Not a member?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F41BB),
          ),

          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

List<Widget> _welcomeText() {
  return [
    GradientText(
      "Get verified instantly",
      colors: [Color(0xFFFF63F0), Color(0xFFC82DB9), Color(0xFF7220FF)],
      gradientDirection: GradientDirection.ltr,
      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    Text(
      "Create an account so you can explore all the communities around you",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  ];
}

List<Widget> _alternativeLogin() {
  return [
    Text(
      "Or continue with",
      style: TextStyle(fontSize: 12),
      textAlign: TextAlign.center,
    ),
    Row(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFECECEC),
          ),
          child: SvgPicture.asset(
            'assets/icons/google-fill.svg',
            fit: BoxFit.scaleDown,
            width: 24,
            height: 24,
          ),
        ),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFECECEC),
          ),
          child: SvgPicture.asset(
            'assets/icons/facebook-fill.svg',
            fit: BoxFit.scaleDown,
            width: 24,
            height: 24,
          ),
        ),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFECECEC),
          ),
          child: SvgPicture.asset(
            'assets/icons/apple-fill.svg',
            fit: BoxFit.scaleDown,
            width: 24,
            height: 24,
          ),
        ),
      ],
    ),
  ];
}
