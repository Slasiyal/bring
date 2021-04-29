import 'package:bringseller/sizeConfig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:bringseller/services/userService.dart';

class Start extends StatefulWidget {
  StartState createState() => new StartState();
}

class StartState extends State<Start> with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((event) {
      if (event != null) {
        validateToken(context, true);
      }
    });
  }

  final UserService _userService = new UserService();

  validateToken(context, bool auto) async {
    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: 'token');
    if (value != null) {
      String decodedToken = _userService.validateToken(value);
      if (decodedToken != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (!auto) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } else if (!auto) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 3),
            ],
          ),
          width: SizeConfig.screenWidth * 0.9,
          height: SizeConfig.screenHeight * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/sIcon.png',
                  height: SizeConfig.safeBlockVertical * 20),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
                child: ButtonTheme(
                  minWidth: SizeConfig.screenWidth - 180,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockVertical * 3),
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'NovaSquare',
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    onPressed: () {
                      validateToken(context, false);
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3.0),
                child: ButtonTheme(
                  minWidth: SizeConfig.screenWidth - 180,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.white, width: 2.6)),
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockVertical * 3),
                    color: Colors.white,
                    textColor: Colors.black,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'NovaSquare',
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
