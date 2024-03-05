import 'package:aichatbot/pages/home_page.dart';
import 'package:flutter/material.dart';
//import 'package:device_preview/device_preview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
      //fontFamily: 'Arimo',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade700,
        primaryColor: Colors.grey,
      ),
    );
  }
}

