
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apk1/screens/signin_screen.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const CircleAvatar(
        radius: 70,
        backgroundImage: AssetImage('assets/images/onepiece.jpg'),
      ),
      nextScreen: const SignInScreen(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.black,
    );
  }
}
