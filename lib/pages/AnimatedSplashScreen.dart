import 'dart:async';

import 'package:bringseller/pages/onBoardingScreen/onboardingScreen.dart';
import 'package:bringseller/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Theme.Const.dart';
import '../sizeConfig.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;
  bool firstTime;
  bool animationCompletd = false;
  startTime() async {
    SharedPreferences.getInstance().then((value) => iniPage(value));

    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    this.animationCompletd = true;
    this.validateToken(context, true);
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  final UserService _userService = new UserService();

  validateToken(context, bool auto) async {
    if (this.animationCompletd) {
      // final storage = new FlutterSecureStorage();
      // String value = await storage.read(key: 'token');
      // if (value != null) {
      //   String decodedToken = _userService.validateToken(value);
      //   if (decodedToken != null) {
      //     Navigator.of(context).pushReplacementNamed('/home');
      //   } else if (!auto) {
      //     Navigator.of(context).pushReplacementNamed('/login');
      //   }
      // } else if (!auto) {
      //   Navigator.of(context).pushReplacementNamed('/login');
      // }
      if(this.auth.currentUser != null){
         Navigator.of(context).pushReplacementNamed('/home');
      }
      else{
         Navigator.of(context).pushReplacementNamed('/start');
      }
      if(!this.firstTime){
        
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OnBoardingScreen()));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((event) {
      if (event != null) {
        validateToken(context, true);
      }
    });
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffbc109),
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onBoarding/onboad_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 30.0), child: copyright)
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'assets/loghori.png',
                  width: animation.value * 250,
                  height: animation.value * 250,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  iniPage(SharedPreferences prefs) {
    firstTime = (prefs.getBool('initScreen') ?? false);
    if (!firstTime) {
      prefs.setBool('initScreen', true);
    }
  }
}
