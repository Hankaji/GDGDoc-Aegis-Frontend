import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gdgdoc/domain/endpoints/location_endpoint.dart';
import 'package:gdgdoc/domain/models/location.dart';
import 'package:gdgdoc/screens/home/map_final.dart';
import 'package:gdgdoc/screens/home/splashscreen.dart';
import 'package:gdgdoc/screens/home/components/review_tab.dart';
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
      home: const MapFinal(),
    );
  }
}

// Example function to call and print location
Future<void> printToConsole() async {
  try {
    final List<Location> locationData = await LocationApi.getLocations();
    for (var ld in locationData) {
      debugPrint('${ld.longitude} : ${ld.latitude}');
    }
  } catch (e) {
    log('Error fetching location: $e');
    throw (Exception(e));
  }
}
