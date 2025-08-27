import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dragonball/screen/dragon_ball_character_sacreen.dart';
import 'google_animals/screen/animals_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        nextScreen: AnimalsView(),
        splash: Image.asset(
          'assets/images/img.png',
          height: 600,
          width: 200,
          fit: BoxFit.contain,
          cacheHeight: 300,
          // color:Colors.transparent,
        ),
        backgroundColor: Colors.blueGrey.withOpacity(0.5),
        splashTransition: SplashTransition.scaleTransition,
      ),
      builder: EasyLoading.init(),
    );
  }
}
