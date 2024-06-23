import 'package:flutter/material.dart';
import 'package:go_restoran/components/bottom_navigation.dart';
import 'package:go_restoran/screen/home_page.dart';
import 'package:go_restoran/screen/welcome/splashscren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BotNav(),
    );
  }
}
