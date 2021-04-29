import 'package:bringseller/pages/AnimatedSplashScreen.dart';
import 'package:bringseller/pages/MyProducts.dart';
import 'package:bringseller/pages/home.dart';
import 'package:bringseller/pages/onBoardingScreen/onboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bringseller/pages/signup.dart';
import 'package:bringseller/pages/login.dart';
import 'package:bringseller/pages/start.dart';

bool firstTime;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // firstTime = false; //(prefs.getBool('initScreen') ?? false);
  // if (!firstTime) {
  //   prefs.setBool('initScreen', true);
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: firstTime ? '/' : '/onBoarding',
      initialRoute: '/',
      routes: {
        '/': (context) => AnimatedSplashScreen(),
        // '/animationSplash': (context) => AnimatedSplashScreen(),
        '/start': (context) => Start(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
        "/onBoarding": (context) => OnBoardingScreen(),
        '/home': (context) => Home(),
        '/products': (context) => MyProducts(),
      },
      theme: ThemeData(
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Colors.white)),
    );
  }
}
