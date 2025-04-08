import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              spacing: 12,
              children: [
                ..._welcomeText(),
                _inputs(),
                SizedBox(height: 64), // TODO: Change according to screen size?
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
    child: Wrap(
      direction: Axis.vertical,
      spacing: 32,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Inputs
        Wrap(
          direction: Axis.vertical,
          spacing: 12,
          children: [
            SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confirm password",
                ),
              ),
            ),
          ],
        ),
        // Action
        Container(
          width: 500,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6E71F5), Color(0xFF6E178B), Color(0xFF7C418F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "Sign up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 500,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Sign up",
            ),
          ),
        ),
        // Already have an account text
        Text(
          "Already had an account?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
    Wrap(
      spacing: 12,
      children: [
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFECECEC),
          ),
        ),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFECECEC),
          ),
        ),
        Container(
          width: 50,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFECECEC),
          ),
        ),
      ],
    ),
  ];
}
