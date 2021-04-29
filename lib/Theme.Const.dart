import 'package:flutter/material.dart';

const Color_Primary = Color(0xffed1c24);
const Color_Base_Secondary = Color(0xfff13138);
const Color_Base_LIGHT = Color(0xffef4e54);
const Color_Label = Color(0xff1f1f1f);
const Color_Label2 = Color(0xff4e4e4e);
const Color_Green = Color(0xff4caf50);

BoxDecoration GRADIENTBUTTON = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  gradient: LinearGradient(
    colors: <Color>[
      Colors.black,
      Colors.black87,
      Colors.black,
    ],
  ),
);

BoxDecoration GRADIENTBUTTONBLUE = BoxDecoration(
  borderRadius: BorderRadius.circular(5.0),
  boxShadow: [
    BoxShadow(
        color: Color_Label2.withOpacity(0.5),
        blurRadius: 5,
        offset: Offset(2, 2))
  ],
  gradient: LinearGradient(
    colors: <Color>[
      Color(0xff673ab7),
      Color(0xff450aad),
      Color(0xff320384),
    ],
  ),
);

Widget copyright = new Text(
    "Copyright @ " + DateTime.now().year.toString() + " Bring App",
    textAlign: TextAlign.center,
    style: TextStyle(
        fontSize: 12,
        color: Colors.black87,
        fontFamily: "NovaSquare",
        letterSpacing: 2,
        height: 1.5,
        fontWeight: FontWeight.w700));

String toCurrency(dynamic value) {
  return "₹ " + double.parse(value.toString()).toStringAsFixed(2);
}

var boxColors = <Color>[Colors.red, Colors.green, Colors.indigoAccent];

const menuBarTextStyle = TextStyle(
    fontFamily: "Bold",
    color: Colors.black54,
    fontSize: 16,
    letterSpacing: 1.0);
