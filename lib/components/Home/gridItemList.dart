import 'package:bringseller/components/Home/particularItem.dart';
import 'package:bringseller/item/customTransition.dart';
import 'package:bringseller/services/ProductService.dart';
import 'package:bringseller/sizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Theme.Const.dart';

class GridItemList extends StatefulWidget {
  String userId;
  GridItemList({@required this.userId}) {}
  @override
  _GridItemListState createState() => _GridItemListState(userId: userId);
}

class _GridItemListState extends State<GridItemList> {
  ProductService _productService = new ProductService();
  String userId;
  _GridItemListState({Key key, @required this.userId}) {
    listFeaturedItems();
  }

  List featuredItems = new List(0);

  void listFeaturedItems() async {
    List featuredItemList = await _productService.getMyProducts(userId);
    setState(() {
      featuredItems = featuredItemList;
    });
  }

  void showParticularItem(Map item) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ParticularItem(
                itemDetails: item, edit: true, userId: widget.userId)));
    // Navigator.push(
    //     context,
    //     CustomTransition(
    //         type: CustomTransitionType.downToUp,
    //         child: ParticularItem(
    //             itemDetails: item, edit: true, userId: widget.userId)));
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    // double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    double itemWidth = size.width / 2;

    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          var item = featuredItems[index];
          return featuredItemCard(item, index);
        }, childCount: featuredItems.length));
  }

  Widget featuredItemCard(item, index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(0, 1)),
        ],
        //  borderRadius: index%2==0? BorderRadius.only(bottomRight: Radius.circular(10),topRight:  Radius.circular(10)):BorderRadius.only(bottomLeft:  Radius.circular(10),topLeft:  Radius.circular(10))
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: GestureDetector(
              onDoubleTap: () {
                showParticularItem(item);
              },
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                             color: index % 2 ==0 ? Colors.red.withOpacity(0.2):Colors.red.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 1)),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade100),
                  padding:
                      EdgeInsets.only(top: 7, left: 7, right: 5, bottom: 5),
                  child: Icon(
                    Icons.delete_sweep,
                      color: index % 2 ==0 ? Colors.red.withOpacity(0.7):Colors.red.withOpacity(0.6),
                    size: 20,
                  )),
            ),
            right: 10,
            bottom: 18,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Hero(
                  tag: "img" + item['productId'].toString(),
                  child: GestureDetector(
                    child: GridTile(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          // borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          child: Image.network(
                            item['image'],
                            // width: SizeConfig.screenWidth * 0.47,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    //Container()
                    ,
                    onTap: () {
                      showParticularItem(item);
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item['name'],
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontFamily: 'Normal'),
                    ),
                    Container(padding: const EdgeInsets.all(5.0)),
                    Text(
                      toCurrency(item["price"]),
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontFamily: 'NovaSquare'),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
