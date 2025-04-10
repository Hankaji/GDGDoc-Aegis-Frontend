import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:gdgdoc/screens/home/map_final.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool _validatePassword(String? value) {
    return value != null && value.isNotEmpty && value.length >= 6;
  }

  void _validateFields() {
    setState(() {
      emailError =
          _validateEmail(emailController.text)
              ? null
              : "Please enter a valid email";
      passwordError =
          _validatePassword(passwordController.text)
              ? null
              : "Password must be at least 6 characters";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ..._welcomeText(),
                _inputs(context),
                const SizedBox(height: 32),
                ..._alternativeLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputs(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Input
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF1F4FF),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Email",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF626262),
                ),
                errorText: emailError,
              ),
              onChanged: (value) => _validateFields(),
            ),
            const SizedBox(height: 12),

            // Password Input
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF1F4FF),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Password",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF626262),
                ),
                errorText: passwordError,
              ),
              onChanged: (value) => _validateFields(),
            ),
            const SizedBox(height: 32),

            // Login Button
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFCBD6FF),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Material(
                type: MaterialType.transparency,
                clipBehavior: Clip.none,
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
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
                    onTap: () {
                      _validateFields();
                      if (emailError == null && passwordError == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MapFinal(),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: const Text(
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
            const SizedBox(height: 16),

            // Sign up text
            const Text(
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
      ),
    );
  }

  List<Widget> _welcomeText() {
    return [
      GradientText(
        "Get verified instantly",
        colors: const [Color(0xFFFF63F0), Color(0xFFC82DB9), Color(0xFF7220FF)],
        gradientDirection: GradientDirection.ltr,
        style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const Text(
        "Create an account so you can explore all the communities around you",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ];
  }

  List<Widget> _alternativeLogin() {
    return [
      const Text(
        "Or continue with",
        style: TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _socialButton('assets/icons/google-fill.svg'),
          const SizedBox(width: 12),
          _socialButton('assets/icons/facebook-fill.svg'),
          const SizedBox(width: 12),
          _socialButton('assets/icons/apple-fill.svg'),
        ],
      ),
    ];
  }

  Widget _socialButton(String assetPath) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFECECEC),
      ),
      child: SvgPicture.asset(
        assetPath,
        fit: BoxFit.scaleDown,
        width: 24,
        height: 24,
      ),
    );
  }
}
