import 'package:bringseller/Theme.Const.dart';
import 'package:bringseller/services/userService.dart';
import 'package:flutter/material.dart';

import 'package:bringseller/components/loader.dart';

import '../sizeConfig.dart';

Widget sidebar(BuildContext context){
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  UserService _userService = UserService();
  return SafeArea(
    child: Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                color: Colors.grey.withOpacity(0.05),
                padding: EdgeInsets.only(left: 30,right: 50),
                child:  Image.asset('assets/loghori.png', height: SizeConfig.safeBlockVertical * 20),
              ),
              Container(padding: EdgeInsets.all(10),),
              ListTile(
                leading: Icon(Icons.home,color: Colors.black54,),
                title:Text(
                  'HOME',
                  style: menuBarTextStyle),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag,color: Colors.black54),
                title:Text(
                  'MY PRODUCTS',
                  style: menuBarTextStyle,
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/products');
                },
              ),
              ListTile(
                leading: Icon(Icons.search,color: Colors.black54),
                title: Text(
                  'SEARCH',
                  style: menuBarTextStyle,
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_shipping,color: Colors.black54),
                title: Text(
                  'ORDERS',
                  style: menuBarTextStyle,
                ),
                onTap: () async {
                
                },
              ),
              ListTile(
                leading: Icon(Icons.person,color: Colors.black54),
                title: Text(
                  'PROFILE',
                  style: menuBarTextStyle,
                ),
                onTap: () async{
                
                },
              ),
              ListTile(
                leading: new Icon(Icons.exit_to_app,color: Colors.black54),
                title: Text(
                  'LOGOUT',
                  style: menuBarTextStyle,
                ),
                onTap: (){
                  _userService.logOut(context);
                },
              )
            ],
          )
        ],
      ),
    ),
  );
}
