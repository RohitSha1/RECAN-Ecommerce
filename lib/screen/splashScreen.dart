import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recan/screen/Entry/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  var gap = const SizedBox(height: 10, width: 10);
  _navigateToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('/Login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('images/assets/ReCaNlogo.png'),
          // const Text('Recan', style: TextStyle(fontSize: 30)),
          gap,
          Container(
            margin: const EdgeInsets.only(left:120, right:120),
            child: const LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 70, 207, 74)),
          ),
          )
          
        ]
        
      ), 
      backgroundColor: const Color.fromARGB(238, 30, 106, 248),
      nextScreen: const Login(),
      splashIconSize: 190,
      duration: 2000,
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      // animationDuration: const Duration(seconds: 2),
      );
  }
}
