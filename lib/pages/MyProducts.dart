import 'package:bringseller/components/Home/Category.dart';
import 'package:bringseller/components/Home/gridItemList.dart';
import 'package:bringseller/components/Home/particularItem.dart';
import 'package:bringseller/components/header.dart';
import 'package:bringseller/components/sidebar.dart';
import 'package:bringseller/item/customTransition.dart';
import 'package:bringseller/services/ProductService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../Theme.Const.dart';
import '../sizeConfig.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProducts createState() => _MyProducts();
}

class _MyProducts extends State<MyProducts> {
  ProductService _productService = new ProductService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Image.asset('assets/loghori.png',
              height: SizeConfig.safeBlockVertical * 3.5),
          centerTitle: true,
          toolbarHeight: 60,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CustomTransition(
                    type: CustomTransitionType.downToUp,
                    child: ParticularItem(
                        itemDetails: null,
                        edit: false,
                        userId: this._auth.currentUser.uid)));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 29,
          ),
          backgroundColor: Colors.black,
          tooltip: 'Add new product',
          elevation: 5,
          splashColor: Colors.grey,
        ),
        body: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            color: Colors.grey.shade100,
            child: CustomScrollView(slivers: <Widget>[
              // SliverList(
              //   delegate: SliverChildListDelegate([

              //     Padding(
              //       padding: EdgeInsets.only(
              //           top: 0.0, bottom: 15.0, left: 20, right: 20),
              //     )
              //   ]),
              // ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 140.0,
                  maxHeight: 140.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      this.Header(),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                          ),
                          child: CategoriesList()),
                    ],
                  ),
                ),
              ),
              new GridItemList(userId: this._auth.currentUser.uid)
            ])));
  }

  Widget Header() {
    return Container(
        decoration: BoxDecoration(color: Colors.grey.shade300),
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.only(bottom: 0),
        height: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: SizeConfig.screenWidth * 0.95,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) => print(value),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Search your products...",
                        prefixIcon: GestureDetector(
                            onTap: () {}, child: Icon(Icons.search)),
                        suffixIcon: Icon(Icons.keyboard_voice)),
                  ),
                ))
          ],
        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
