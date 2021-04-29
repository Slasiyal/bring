import 'package:bringseller/services/ProductService.dart';
import 'package:bringseller/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListOrders extends StatefulWidget {
  @override
  ListOrdersState createState() => ListOrdersState();
}

class ListOrdersState extends State<ListOrders> {
  ProductService _productService = new ProductService();
  ListOrdersState() {
    this.getAllOrders();
  }
  List orderItems = new List(0);
  getAllOrders() async {
    List featuredItemList = await this._productService.listOrder(10);
    setState(() {
      orderItems = featuredItemList;
    });
  }

  buildItem(BuildContext context, int index) {
    if (index == 0) {
      // return the header
      return Container(
        child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.0))),
            padding: EdgeInsets.only(left: 10, bottom: 8, right: 5, top: 10),
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text("Order",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontFamily: 'Bold')),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Quantity",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontFamily: 'Bold')),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Date",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontFamily: 'Bold')),
                )
              ],
            )),
      );
    }
    index -= 1;
    return Container(
      child: Container(
          padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Text(orderItems[index]["name"],
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontFamily: 'Normal')),
              ),
              Expanded(
                flex: 2,
                child: Text(orderItems[index]["qty"].toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontFamily: 'Normal')),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    DateFormat('MMM-dd-yyyy').format(orderItems[index]["date"]),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontFamily: 'Normal')),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: orderItems == null || orderItems.length == 0
            ? 1
            : orderItems.length + 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return buildItem(context, index);
        },
      ),
    );
  }
}
