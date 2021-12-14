import 'package:flutter/material.dart';

import 'UI/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      ///Setting the splash screen for 3 seconds then displaying home page
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            title: 'Wallpaper Hub',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.white,
            ),
            home: Splash(),
          );
        }
      },
    );
  }
}
