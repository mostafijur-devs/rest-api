import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dragonball/screen/dragon_ball_character_sacreen.dart';
import 'google_animals/screen/animals_view.dart';

void main (){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimalsView(),
      builder:EasyLoading.init() ,
    );
  }
}
