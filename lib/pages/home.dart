import 'package:bringseller/components/Home/list.order.dart';
import 'package:bringseller/components/sidebar.dart';
import 'package:bringseller/item/customTransition.dart';
import 'package:bringseller/pages/MyProducts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bringseller/components/header.dart';
import 'package:flutter/services.dart';

import '../sizeConfig.dart';
import '../Extension/StringExt.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String userNm = "Bring";
  _HomeState() {
    _auth.authStateChanges().listen((event) {
      setState(() {
        userNm = event.displayName;
      });
    });
    userNm = _auth.currentUser.displayName;
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    bool showCartIcon = true;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return WillPopScope(
      onWillPop: () async {
        return (await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                      title: Text('Are you sure ?'),
                      content: Text('Do you want to exit an App'),
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
                          onPressed: () => Navigator.of(context).pop(true),
                          child: Text('Yes',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                        )
                      ],
                    ))) ??
            false;
      },
      child: Scaffold(
          key: _scaffoldKey,
          appBar: header('Bring App', _scaffoldKey, showCartIcon, context),
          drawer: sidebar(context),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight * 0.89,
                  padding: EdgeInsets.only(left: 10, right: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              userNm == null
                                  ? "Bring"
                                  : userNm.capitalizeFirstofEach,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'NovaSquare'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Container(
                                width: 42,
                                height: 42,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color(0xffF4F4F4),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Image.asset(
                                  'assets/share.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 10, bottom: 20),
                        width: double.infinity,
                        color: Color(0xffE5E5E5),
                        height: 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth * 0.45,
                              height: SizeConfig.screenWidth * 0.34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/shopping.png",
                                      width: SizeConfig.screenWidth * 0.09),
                                  Text(
                                    "Orders",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'NovaSquare'),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth * 0.45,
                              height: SizeConfig.screenWidth * 0.34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/Revenue.png",
                                      width: SizeConfig.screenWidth * 0.14),
                                  Text(
                                    "Revenue",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'NovaSquare'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15, top: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth * 0.45,
                              height: SizeConfig.screenWidth * 0.34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomTransition(
                                          type: CustomTransitionType.upToDown,
                                          child: MyProducts()));
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/produc_view.png",
                                        width: SizeConfig.screenWidth * 0.12),
                                    Text(
                                      "Produc view",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'NovaSquare'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth * 0.45,
                              height: SizeConfig.screenWidth * 0.34,
                              decoration: BoxDecoration(
                                  color: Color(0xffE5E5E5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/store.png",
                                      width: SizeConfig.screenWidth * 0.12),
                                  Text(
                                    "Store view",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'NovaSquare'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  child: Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        width: SizeConfig.screenWidth,
                        child: Text("Active orders",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontFamily: 'Medium')),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        color: Colors.white,
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.19,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffE5E5E5),
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(12),
                            child: ListOrders()),
                      ),
                      Container(
                        color: Color(0xffE5E5E5),
                        width: SizeConfig.screenWidth,
                        height: 2,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Center(
                                child: FlatButton(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF4F4F4),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'assets/loc.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Center(
                                child: FlatButton(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.only(
                                        left: 12,
                                        top: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF4F4F4),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'assets/note.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Center(
                                child: FlatButton(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF4F4F4),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'assets/new-product.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.25,
                              child: Center(
                                child: FlatButton(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF4F4F4),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.asset(
                                      'assets/user.png',
                                      width: 18,
                                      height: 18,
                                    ),
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                  bottom: 2,
                  left: 0,
                ),
              ],
            ),
          )),
    );
  }
}
