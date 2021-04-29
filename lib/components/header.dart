import 'package:bringseller/components/loader.dart';

import 'package:flutter/material.dart';

import '../sizeConfig.dart';

capitalizeHeading(String text) {
  if (text == null) {
    return text = "";
  } else {
    text = "${text[0].toUpperCase()}${text.substring(1)}";
    return text;
  }
}

Widget header(String headerText, GlobalKey<ScaffoldState> scaffoldKey,
    bool showIcon, BuildContext context) {
  final GlobalKey<State> keyLoader = new GlobalKey<State>();

  return AppBar(
    centerTitle: true,
    title: Image.asset('assets/loghori.png',
        height: SizeConfig.safeBlockVertical * 3.5),
    backgroundColor: Color(0xffE5E5E5),
    elevation: 1.0,
    automaticallyImplyLeading: false,
    leading: FlatButton(
      child: Image.asset(
        'assets/Rounded Rectangle 5 copy 2.png',
        width: 25,
        height: 25,
      ),
      onPressed: () {
        if (scaffoldKey.currentState.isDrawerOpen == false) {
          scaffoldKey.currentState.openDrawer();
        } else {
          scaffoldKey.currentState.openEndDrawer();
        }
      },
    ),
    actions: <Widget>[
      Visibility(
        visible: showIcon,
        child: FlatButton(
          child: Container(
            width: 36,
            height: 36,
            padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(18)),
            child: Image.asset(
              'assets/store.png',
              width: 20,
              height: 20,
            ),
          ),
          onPressed: () async {},
        ),
      )
    ],
  );
}

