// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_restoran/screen/auth/register_page.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  void _onIntroEnd(context) {
    Navigator.pushAndRemoveUntil(
        context,
        // MaterialPageRoute(builder: (context) => BotNavBar()), (route) => false);
        MaterialPageRoute(builder: (context) => Registerpage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        )),
        child: OnBoardingAnimation(
          pages: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 19),
                    child: Container(
                      width: 300,
                      height: 90,
                      child: Image.asset(
                        'assets/logo2.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text(
                      "Ayo Kembali Rasakan Kehangatan Kampung Halaman  Bersama Kami",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Rubik',
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 52,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onIntroEnd(context);
                    },
                    child: Container(
                      width: 295,
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(97, 17, 97, 18),
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onIntroEnd(context);
                    },
                    child: Text(
                      "skip",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: 300,
                      height: 90,
                      child: Image.asset(
                        'assets/logo2.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: 350,
                      height: 240,
                      child: Image.asset(
                        'assets/img1.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 85, left: 20, right: 20),
                    child: Text(
                      "Temukan Resep Tradisional & Pelajari Makanan Khas Kampung Halaman Anda!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Rubik',
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 52,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onIntroEnd(context);
                    },
                    child: Container(
                      width: 295,
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(97, 17, 97, 18),
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onIntroEnd(context);
                    },
                    child: Text(
                      "skip",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: 300,
                      height: 90,
                      child: Image.asset(
                        'assets/logo2.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 85),
                    child: Text(
                      "Kembangkan kemampuan Anda dengan berbagai event yang kami tawarkan. Bergabunglah sekarang!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Rubik',
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 52,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onIntroEnd(context);
                    },
                    child: Container(
                      width: 295,
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(97, 17, 97, 18),
                        child: Text(
                          "Get Started",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  GestureDetector(
                    onTap: () {
                      _onIntroEnd(context);
                    },
                    child: Text(
                      "skip",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
          indicatorDotHeight: 1.0,
          indicatorDotWidth: 1.0,
          indicatorType: IndicatorType.expandingDots,
          indicatorPosition: IndicatorPosition.bottomCenter,
        ),
      ),
    );
  }
}
