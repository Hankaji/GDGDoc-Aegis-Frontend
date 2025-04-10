import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gdgdoc/screens/home/map_final.dart';

// void main() {
//   runApp(const MainApp());
// }
//
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return PlatformProvider(
//       builder:
//           (context) => PlatformTheme(
//             materialLightTheme: ThemeData.light().copyWith(
//               textTheme: GoogleFonts.poppinsTextTheme(
//                 Theme.of(context).textTheme,
//               ),
//             ),
//             materialDarkTheme: ThemeData.dark().copyWith(
//               textTheme: GoogleFonts.poppinsTextTheme(
//                 Theme.of(context).textTheme,
//               ),
//             ),
//             builder:
//                 (context) => PlatformApp(
//                   localizationsDelegates: <LocalizationsDelegate<dynamic>>[
//                     DefaultMaterialLocalizations.delegate,
//                     DefaultWidgetsLocalizations.delegate,
//                     DefaultCupertinoLocalizations.delegate,
//                   ],
//                   title: 'Aegis',
//                   home: MapImageScreen(),
//                 ),
//           ),
//     );
//   }
// }
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
      home: const Home(),
    );
  }
}
