import 'package:cloud_firestore/cloud_firestore.dart';

import 'userService.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _productReference =
      FirebaseFirestore.instance.collection('products');
  CollectionReference _categoryReference =
      FirebaseFirestore.instance.collection('categories');
  UserService _userService = new UserService();
  List listProducts = List();
  Future<List> getMyProducts(userId) async {
    QuerySnapshot products =
        await _productReference.where('userId', isEqualTo: userId).get();
    List listProducts = new List();
    for (int i = 0; i < products.docs.length; i++) {
      Map product = products.docs[i].data();

      listProducts.add({
        'name': product['name'],
        'price': product['price'],
        'isAvailable': product['isAvailable'],
        'image': product['image'],
        'tags': product['tags'],
        'userId': product['userId'],
        'productId': product['productId'],
        'categoryId': product['categoryId'],
        'categoryName': product['categoryName'],
      });
    }
    return listProducts;
  }

  Future<List> listCategories() async {
    QuerySnapshot _categoryRef =
        await _categoryReference.where("isEnabled", isEqualTo: true).get();

    List<Map<String, String>> categoryList = new List();
    for (DocumentSnapshot dataRef in _categoryRef.docs) {
      Map<String, String> category = new Map();
      category['name'] = dataRef.data()['name'];
      category['image'] = dataRef.data()['image'];
      category['id'] = dataRef.id;
      categoryList.add(category);
    }
    return categoryList;
  }

  Future<List> listOrder(int max) async {
    List orders = new List();
    orders.add({"name": "Parmal rice", "qty": 5, "date": new DateTime.now()});
    orders.add({"name": "Dhaniya powder", "qty": 1, "date": new DateTime.now()});
    orders.add({"name": "Namkeen Haldiram", "qty": 1, "date": new DateTime.now()});
    orders.add({"name": "Chana Dal", "qty": 2, "date": new DateTime.now()});

    return orders;
  }

  Future<void> saveProduct(String userId, productValue) async {
    if (productValue["productId"] == "") {
      productValue["productId"] = this._productReference.doc().id;
    }

    _productReference
        .doc(productValue["productId"])
        .set(productValue)
        .whenComplete(() => {});
  }
}
