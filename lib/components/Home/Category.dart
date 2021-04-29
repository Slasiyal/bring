import 'package:bringseller/Theme.Const.dart';
import 'package:bringseller/services/ProductService.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  @override
  CategoriesListState createState() => CategoriesListState();
}

class CategoriesListState extends State<CategoriesList> {
  ProductService _productService = new ProductService();
  CategoriesListState() {
    this.getAllCategoires();
  }
  List featuredItems = new List(0);
  getAllCategoires() async {
    List featuredItemList = await this._productService.listCategories();
    setState(() {
      featuredItems = featuredItemList;
    });
  }

  // buildItem(BuildContext context, int index) {
  //   return Container(
  //     // width: MediaQuery.of(context).size.width / 6,
  //     // height: MediaQuery.of(context).size.height / 11,

  //     child: Container(
  //         child: Column(
  //       children: <Widget>[
  //         Container(
  //           margin: EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 3),
  //           //padding: EdgeInsets.all(5),
  //           decoration: BoxDecoration(color: Colors.white,
  //               // border: Border.all(
  //               //     color: Color_Base_LIGHT.withOpacity(0.5), width: 1),
  //                borderRadius: BorderRadius.all(Radius.circular(10)),
  //               boxShadow: [
  //                 BoxShadow(
  //                   offset: Offset(1,2),
  //                   color: Colors.black.withOpacity(0.5),
  //                   blurRadius: 5.0,
  //                 ),
  //               ]),
  //           child: ClipRRect(
  //              borderRadius: BorderRadius.all(Radius.circular(10)),
  //             child: Image.network(
  //               featuredItems[index]["image"],
  //               fit: BoxFit.cover,
  //               height: 116,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.all(2),
  //         ),
  //         Text(
  //           featuredItems[index]["name"],
  //            overflow: TextOverflow.ellipsis,
  //                     textAlign: TextAlign.left,
  //                     style: TextStyle(fontSize: 15.0, color: Colors.black87, fontFamily: 'NovaSquare',),
  //         )
  //       ],
  //     )),
  //   );
  // }
  buildItem(BuildContext context, int index) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.only(left: 25, right: 25, top: 7, bottom: 7),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
            border: Border.all(color: boxColors[index % 3]),
            boxShadow: [
              BoxShadow(
                  color: boxColors[index % 3].withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(1, 2)),
            ]),
        child: Text(featuredItems[index]["name"],
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 15.0,
                color: boxColors[index % 3],
                fontFamily: 'Medium')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.builder(
        itemCount: featuredItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildItem(context, index);
        },
      ),
    );
  }
}
