import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:gdgdoc/screens/home/map_image.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
      builder:
          (context) => PlatformTheme(
            builder:
                (context) => PlatformApp(
                  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                    DefaultMaterialLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                  ],
                  title: 'Aegis',
                  home: MapImageScreen(),
                ),
          ),
    );

    // return const MaterialApp(
    //   title: "Aegis",
    //   home: Scaffold(
    //     body: Center(child: Text('Hello World!')),
    //     backgroundColor: Color(0xFFFF3080),
    //   ),
    // );
  }
}
