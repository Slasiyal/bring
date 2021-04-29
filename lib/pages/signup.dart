import 'dart:collection';
import 'package:bringseller/components/loader.dart';
import 'package:flutter/material.dart';

import 'package:bringseller/components/alertBox.dart';
import 'package:bringseller/services/userService.dart';
import 'package:bringseller/services/validateService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../sizeConfig.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double borderWidth = 1.0;
  final _signUpFormKey = GlobalKey<FormState>();
  HashMap userValues = new HashMap<String, String>();
  Map customWidth = new Map<String, double>();
  double fieldPadding;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  ValidateService validateService = ValidateService();
  UserService userService = UserService();

  setBorder(double width, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide(width: width, color: color),
    );
  }

  validateToken(context, bool auto) async {
    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: 'token');
    if (value != null) {
      String decodedToken = userService.validateToken(value);
      if (decodedToken != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (!auto) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } else if (!auto) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  signUpUser() async {
    if (this._signUpFormKey.currentState.validate()) {
      _signUpFormKey.currentState.save();
      Loader.showLoadingScreen(context, _keyLoader);
      await userService.signup(userValues);
      int statusCode = userService.statusCode;
      if (statusCode == 400) {
        AlertBox alertBox = AlertBox(userService.msg);
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertBox.build(context);
            });
      } else {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
                  title: Text('Your account created successfully?'),
                  content: Text('Do you want to login app'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    FlatButton(
                      onPressed: () => validateToken(context, false),
                      child: Text('Yes',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    )
                  ],
                ));
      }
    }
  }

  InputDecoration customFormField(String text) {
    return InputDecoration(
        hintText: text,
        labelText: text,
        prefixIcon: setFormIcons(text),
        contentPadding: EdgeInsets.all(customWidth['fieldPadding']),
        errorBorder: this.setBorder(1.8, Colors.red),
        focusedErrorBorder: this.setBorder(1.2, Colors.red),
        focusedBorder: this.setBorder(2.0, Colors.blue),
        enabledBorder: this.setBorder(1.0, Colors.white),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3));
  }

  setUpFieldPadding(screen) {
    switch (screen) {
      case 'smallMobile':
        {
          customWidth['fieldPadding'] = 10.00;
          customWidth['formFieldSpacing'] = SizeConfig.safeBlockVertical * 2.4;
          customWidth['fieldTextSize'] = SizeConfig.safeBlockVertical * 2.6;
          break;
        }
      case 'largeMobile':
        {
          customWidth['fieldPadding'] = 20.00;
          customWidth['formFieldSpacing'] = SizeConfig.safeBlockVertical * 2.6;
          customWidth['fieldTextSize'] = SizeConfig.safeBlockVertical * 2.2;
          break;
        }
      case 'tablet':
        {
          customWidth['fieldPadding'] = 26.00;
          customWidth['formFieldSpacing'] = SizeConfig.safeBlockVertical * 5;
          customWidth['fieldTextSize'] = SizeConfig.safeBlockVertical * 2.4;
          break;
        }
      default:
        break;
    }
  }

  Icon setFormIcons(String label) {
    Icon icon;
    switch (label) {
      case 'Bussiness name':
        {
          icon = Icon(Icons.person);
          break;
        }
      case 'Email':
        {
          icon = Icon(Icons.email);
          break;
        }
      case 'Mobile number':
        {
          icon = Icon(Icons.call);
          break;
        }
      case 'Password':
        {
          icon = Icon(Icons.lock);
          break;
        }
      case 'Postal Code':
        {
          icon = Icon(Icons.location_on);
          break;
        }
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    setUpFieldPadding(SizeConfig.screenSize);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical / 2,
              horizontal: SizeConfig.safeBlockHorizontal * 10),
          child: Form(
            key: _signUpFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Let's Get Started",
                  style: TextStyle(
                      fontFamily: 'NovaSquare',
                      fontSize: SizeConfig.safeBlockHorizontal * 8.0),
                ),
                Text(
                  'Create an account to get all features',
                  style: TextStyle(
                    fontFamily: 'NovaSquare',
                    fontSize: SizeConfig.safeBlockHorizontal * 3.8,
                    color: Colors.grey[800],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeAreaVertical * 0.8),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: this.customFormField('Bussiness name'),
                        validator: (value) =>
                            validateService.isEmptyField(value),
                        onSaved: (String val) {
                          userValues['fullName'] = val;
                        },
                        style:
                            TextStyle(fontSize: customWidth['fieldTextSize']),
                      ),
                      SizedBox(height: customWidth['formFieldSpacing']),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: this.customFormField('Postal Code'),
                        validator: (value) =>
                            validateService.isValidPostalCode(value),
                        onSaved: (String val) {
                          userValues['postalcode'] = val;
                        },
                        style:
                            TextStyle(fontSize: customWidth['fieldTextSize']),
                      ),
                      SizedBox(height: customWidth['formFieldSpacing']),
                      TextFormField(
                        decoration: this.customFormField('Mobile number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            validateService.validatePhoneNumber(value),
                        onSaved: (String val) {
                          userValues['mobileNumber'] = val;
                        },
                        style:
                            TextStyle(fontSize: customWidth['fieldTextSize']),
                      ),
                      SizedBox(height: customWidth['formFieldSpacing']),
                      TextFormField(
                        decoration: this.customFormField('Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            validateService.validateEmail(value),
                        onSaved: (String val) {
                          userValues['email'] = val;
                        },
                        style:
                            TextStyle(fontSize: customWidth['fieldTextSize']),
                      ),
                      SizedBox(height: customWidth['formFieldSpacing']),
                      TextFormField(
                        decoration: this.customFormField('Password'),
                        obscureText: true,
                        validator: (value) =>
                            validateService.validatePassword(value),
                        onSaved: (String val) {
                          userValues['password'] = val;
                        },
                        style:
                            TextStyle(fontSize: customWidth['fieldTextSize']),
                      ),
                      SizedBox(height: customWidth['formFieldSpacing']),
                      ButtonTheme(
                        minWidth: SizeConfig.screenWidth - 200,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                              side: BorderSide(color: Colors.black)),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: Colors.black87,
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'NovaSquare',
                                fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            this.signUpUser();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
