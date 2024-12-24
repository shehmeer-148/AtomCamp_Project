import 'package:cleanproject/presentation/screens/App_intro_screens/onboarding_screens/onboarding_page.dart';
import 'package:cleanproject/presentation/screens/User_screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    super.initState();
    returntohomepage();
  }

  Future<void> returntohomepage()async{
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingPage()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5b9ee2), // Matches native splash background
      body: Center(
        child: Lottie.asset(
          'animations/animation2.json', // Replace with your Lottie file
          width: 300,
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }


}

