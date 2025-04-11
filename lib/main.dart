import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/splashscreen.dart';
import 'package:gdgdoc/domain/api_service.dart';
import 'package:gdgdoc/domain/endpoints/review_endpoint.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the screen orientation to portrait.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  printToConsole();

  runApp(const _Home());
}

class _Home extends StatelessWidget {
  const _Home();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const Splashscreen(),
    );
  }
}

// Example function to call and print location
Future<void> printToConsole() async {
  try {
    final locationData = await ApiService.get("locations");
    final reviews = await ReviewApi.getReviewsByLocationId(
      "7f61ef13-2474-431a-9c75-b3bde1afbb37",
    );
    print('Location data: $locationData');
    print('Reviews: $reviews');
  } catch (e) {
    print('Error fetching location: $e');
  }
}
