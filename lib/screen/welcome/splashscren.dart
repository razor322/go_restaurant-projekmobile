// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_restoran/screen/welcome/onboarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => OnboardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Image.asset('assets/logo.png'),
          ),
        ));
  }
}
