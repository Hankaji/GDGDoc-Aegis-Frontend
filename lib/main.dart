import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the screen orientation to portrait.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const _AirbnbMobileAppExample());
}

class _AirbnbMobileAppExample extends StatelessWidget {
  const _AirbnbMobileAppExample();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const Splashscreen(),
    );
  }
}
