import 'dart:collection';
import 'dart:io';
import 'dart:ui';
import 'dart:wasm';

import 'package:bringseller/components/loader.dart';
import 'package:bringseller/item/customTransition.dart';
import 'package:bringseller/pages/MyProducts.dart';
import 'package:bringseller/services/ProductService.dart';
import 'package:bringseller/services/validateService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Theme.Const.dart';
import '../../Extension/StringExt.dart';
import '../../sizeConfig.dart';
import '../TagButton.dart';
import '../alertBox.dart';

typedef capturedImageFile = String Function(String);
typedef void x(double maxWidth, double maxHeight, int quality);

class ParticularItem extends StatefulWidget {
  Map<String, dynamic> itemDetails;
  final bool edit;
  final String userId;

  ParticularItem({var key, this.itemDetails, this.edit, this.userId})
      : super(key: key);

  @override
  _ParticularItemState createState() => _ParticularItemState();
}

class _ParticularItemState extends State<ParticularItem> {
  FirebaseStorage _storage = FirebaseStorage.instance;
  String _imageFile;
  var _width;
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  final TextEditingController _typeAheadController = TextEditingController();
  ValidateService validateService = ValidateService();
  ProductService productService = ProductService();
  final _ProductFormKey = GlobalKey<FormState>();
  Map customWidth = new Map();
  final GlobalKey<ScaffoldState> _productScaffoldKey =
      new GlobalKey<ScaffoldState>();
  void showInSnackBar(String msg, Color color) {
    _productScaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            _productScaffoldKey.currentState.removeCurrentSnackBar();
          },
        ),
      ),
    );
  }

  setCustomWidth(String screenSize) {
    print(screenSize);
    if (screenSize == 'smallMobile') {
      customWidth['sizeBoxHeight'] = SizeConfig.safeBlockVertical * 7.5;
    } else if (screenSize == 'largeMobile') {
      customWidth['sizeBoxHeight'] = SizeConfig.safeBlockVertical * 6.5;
    } else if (screenSize == 'tablet') {
      customWidth['sizeBoxHeight'] = SizeConfig.safeBlockVertical * 6.5;
    }
  }

  @override
  void initState() {
    super.initState();
    if (!widget.edit) {
      widget.itemDetails = new Map();
      widget.itemDetails["name"] = "";
      widget.itemDetails["price"] = 0;
      widget.itemDetails["isAvailable"] = true;
      widget.itemDetails["image"] = null;
      widget.itemDetails["tags"] = [];
      widget.itemDetails["userId"] = widget.userId;
      widget.itemDetails["categoryId"] = [];
      widget.itemDetails["categoryName"] = "";
      widget.itemDetails["productId"] = "";
    } else {
      if (widget.itemDetails["price"] is String) {
        widget.itemDetails["price"] =
            double.parse(widget.itemDetails["price"].toString());
      }

      _typeAheadController.text = widget.itemDetails["categoryName"];
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    _width = MediaQuery.of(context).size.width;
    SizeConfig().init(buildContext);
    setCustomWidth(SizeConfig.screenSize);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _productScaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.edit ? 'Edit product' : 'Add new product',
          style: TextStyle(
              fontFamily: 'NovaSquare',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: SizeConfig.safeBlockHorizontal * 8,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,
                size: SizeConfig.safeBlockHorizontal * 7, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Form(
                  key: _ProductFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Hero(
                            tag: "img" +
                                widget.itemDetails["productId"].toString(),
                            child: _imageFile != null ||
                                    widget.itemDetails["image"] != null
                                ? Container(
                                    // height: _width,
                                    // decoration: BoxDecoration(
                                    //   boxShadow: [
                                    //     BoxShadow(
                                    //         blurRadius: 10,
                                    //         color: Colors.grey.withOpacity(0.5),
                                    //         offset: Offset(0, 2))
                                    //   ],
                                    //   borderRadius: BorderRadius.all(
                                    //     Radius.circular(10),
                                    //   ),
                                    //   color: Colors.white,
                                    // ),
                                    child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        _imageFile != null
                                            ? Image.file(
                                                File(_imageFile),
                                                // height: _width,
                                                // width: _width,
                                                alignment: Alignment.centerLeft,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Image.network(
                                                widget.itemDetails["image"],
                                                height: _width,
                                                width: _width,
                                                alignment: Alignment.centerLeft,
                                                fit: BoxFit.fitWidth,
                                              ),
                                        Positioned(
                                          top: 20,
                                          right: 10,
                                          child: GestureDetector(
                                              onTap: () {
                                                print('delete image from List');
                                                setState(() {
                                                  widget.itemDetails["image"] =
                                                      null;
                                                  _imageFile = null;
                                                });
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.white),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 10,
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        offset: Offset(0, 2))
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                  color: Colors.red
                                                      .withOpacity(0.4),
                                                ),
                                              )),
                                        )
                                      ],
                                    ),
                                  ))
                                : Container(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeAreaVertical * 0.8),
                            child: Column(children: <Widget>[
                              SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    initialValue: widget.itemDetails['name'],
                                    decoration:
                                        this.customFormField('Product name'),
                                    validator: (value) => validateService
                                        .isEmptyFieldMin(value, 4),
                                    onSaved: (String val) {
                                      setState(() {
                                        widget.itemDetails['name'] = val;
                                      });
                                    },
                                    style: TextStyle(
                                        fontSize: customWidth['fieldTextSize']),
                                  )),
                              Container(padding: EdgeInsets.all(10)),
                              TypeAheadFormField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          controller: this._typeAheadController,
                                          decoration:
                                              this.customFormField('Category')),
                                  suggestionsCallback: (pattern) {
                                    return productService.listCategories();
                                  },
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                        title: Text(suggestion['name']));
                                  },
                                  transitionBuilder:
                                      (context, suggestionsBox, controller) {
                                    return suggestionsBox;
                                  },
                                  onSuggestionSelected: (suggestion) {
                                    setState(() {
                                      this._typeAheadController.text =
                                          suggestion["name"];
                                      widget.itemDetails['categoryId'] =
                                          suggestion["id"];
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please select a category';
                                    }
                                  },
                                  onSaved: (newValue) {
                                    setState(() {
                                      widget.itemDetails['categoryName'] =
                                          newValue;
                                    });
                                  }),
                              Container(padding: EdgeInsets.all(10)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.35,
                                    child: TextFormField(
                                      initialValue: widget.itemDetails['price']
                                          .toString(),
                                      keyboardType: TextInputType.number,
                                      decoration: this.customFormField('Price'),
                                      validator: (value) => validateService
                                          .isEmptyFieldMin(value, 1),
                                      onSaved: (String val) {
                                        setState(() {
                                          widget.itemDetails['price'] = val;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize:
                                              customWidth['fieldTextSize']),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.1,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.35,
                                    child: ListTileTheme(
                                      contentPadding: EdgeInsets.all(0),
                                      child: Container(
                                        // decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(5),
                                        //     border: Border.all(color: Colors.grey)),
                                        child: CheckboxListTile(
                                          value:
                                              widget.itemDetails["isAvailable"],
                                          title: Text('Available',
                                              style: TextStyle(
                                                color: Colors.black54,
                                              )),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          onChanged: (value) {
                                            setState(() {
                                              widget.itemDetails[
                                                  "isAvailable"] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(padding: EdgeInsets.all(10)),
                              Container(
                                padding: EdgeInsets.only(top: 0),
                                width: double.infinity,
                                height: 40,
                                child: Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var it = [];
                                        if (index ==
                                            widget.itemDetails["tags"].length) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: 2, bottom: 5,left: 15),
                                            color: Colors.white,
                                            child: GestureDetector(
                                                onTap: () {
                                                  _displayTextInputDialog(
                                                      context, -1);
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: 10,left: 5,right: 5),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                  BoxShadow(
                                                      color:Colors.black
                                                              .withOpacity(0.3),
                                                      blurRadius: 2,
                                                      spreadRadius: 2,
                                                      offset: Offset(0, 1)),
                                                ],
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    "Add new tag",
                                                    style: TextStyle(
                                                        fontFamily: "Normal",
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                )),
                                          );
                                        }

                                        return Container(
                                          child: Container(
                                        
                                            decoration: BoxDecoration(
                                                // gradient: LinearGradient(
                                                //     colors: <Color>[
                                                //       Color(0xffffd95f),
                                                //       Color(0xfffbc109),
                                                //       Color(0xffffd95f),
                                                //     ],
                                                //     begin: Alignment.topCenter,
                                                //     end:
                                                //         Alignment.bottomCenter),
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //       blurRadius: 2,
                                                //       color: Color(0xffffd95f).withOpacity(0.5),
                                                //       offset: Offset(0, 2))
                                                // ],
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          boxColors[index % 3]
                                                              .withOpacity(0.3),
                                                      blurRadius: 2,
                                                      spreadRadius: 3,
                                                      offset: Offset(1, 1)),
                                                ],
                                                color: boxColors[index % 3],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            margin: EdgeInsets.only(
                                                right: 10, bottom: 3,left: 4,top: 3),
                                            padding: EdgeInsets.only(right: 15),
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                    child: FlatButton(
                                                  // color: Colors.black,
                                                  onPressed: () {
                                                    _displayTextInputDialog(
                                                        context, index);
                                                  },
                                                  child: Text(
                                                      widget.itemDetails["tags"]
                                                          [index],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: "Normal",
                                                          color: Colors.white,
                                                          fontSize: 12)),
                                                )),
                                                TagButton(
                                                  index: index,
                                                  onPressed: (i) {
                                                    setState(() {
                                                      var data = widget
                                                          .itemDetails["tags"];
                                                      data.removeAt(i);
                                                      widget.itemDetails[
                                                          "tags"] = data;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          widget.itemDetails["tags"].length + 1,
                                    ),
                                  ),
                                ),
                              ),
                              Container(padding: EdgeInsets.all(15)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                      width: SizeConfig.screenWidth * 0.42,
                                      child: _imageFile == null &&
                                              widget.itemDetails["image"] ==
                                                  null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: FlatButton(
                                                child: Text(
                                                  "Image from camera",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                                onPressed: () {
                                                  onImageButtonPressed(
                                                    ImageSource.camera,
                                                    context: context,
                                                    capturedImageFile: (s) {
                                                      setState(() {
                                                        _imageFile = s;
                                                      });
                                                    },
                                                  );
                                                },
                                              ),
                                            )
                                          : Container()),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.07,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.42,
                                    child: _imageFile == null &&
                                            widget.itemDetails["image"] == null
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: FlatButton(
                                              child: Text("Image from gallary",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14)),
                                              onPressed: () {
                                                onImageButtonPressed(
                                                  ImageSource.gallery,
                                                  context: context,
                                                  capturedImageFile: (s) {
                                                    setState(() {
                                                      _imageFile = s;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // gradient: LinearGradient(
                                    //     colors: <Color>[
                                    //       Colors.black.withOpacity(0.7),
                                    //       Colors.black,
                                    //       Colors.black.withOpacity(0.7),
                                    //     ],
                                    //     begin: Alignment.topCenter,
                                    //     end: Alignment.bottomCenter),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          color: Colors.black.withOpacity(0.3),
                                          offset: Offset(0, 2))
                                    ],
                                    color:Colors.green,
                                    borderRadius: BorderRadius.circular(5)),
                                child: FlatButton(
                                  child: Text(
                                    "Save Product",
                                    style: TextStyle(color: Colors.white,fontFamily: "Normal",fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    if (this
                                        ._ProductFormKey
                                        .currentState
                                        .validate()) {
                                      _ProductFormKey.currentState.save();

                                      if (this._imageFile != null) {
                                        Loader.showLoadingScreen(
                                            context, this.keyLoader);
                                        String url = await uploadPic();
                                        widget.itemDetails["image"] = url;
                                      }
                                      if (widget.itemDetails["image"] == null &&
                                          this._imageFile == null) {
                                        return showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0)),
                                                  title: Text('Error'),
                                                  content: Text(
                                                      'Please upload product image'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('OK',
                                                          style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.red)),
                                                    )
                                                  ],
                                                ));
                                      } else {
                                        if (this._imageFile == null) {
                                          Loader.showLoadingScreen(
                                              context, this.keyLoader);
                                        }
                                        this.saveData(context);
                                      }
                                    }
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                              ),
                            ]))
                      ])))),
    );
  }

  InputDecoration customFormField(String text) {
    return InputDecoration(
        hintText: text,
        labelText: text,
        contentPadding: EdgeInsets.all(15),
        border: this.setBorder(1.8, Colors.black),
        errorBorder: this.setBorder(1.8, Colors.red),
        focusedErrorBorder: this.setBorder(1.2, Colors.red),
        focusedBorder: this.setBorder(2.0, Colors.blue),
        enabledBorder: this.setBorder(1.0, Colors.grey),
        fillColor: Colors.white,
        filled: true,
        errorStyle: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 3));
  }

  setBorder(double width, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(width: width, color: color),
    );
  }

  TextEditingController _textFieldController = TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context, int index) async {
    _textFieldController.text =
        index > -1 ? widget.itemDetails["tags"][index] : "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit your tag'),
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Edit your tag"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    if (index > -1) {
                      widget.itemDetails["tags"][index] =
                          _textFieldController.text.capitalizeFirstofEach;
                    } else if (_textFieldController.text.isNotEmpty) {
                      widget.itemDetails["tags"].add(_textFieldController.text.capitalizeFirstofEach);
                    }
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  onImageButtonPressed(ImageSource source,
      {BuildContext context, capturedImageFile}) async {
    final ImagePicker _picker = ImagePicker();
    File val;

    final pickedFile = await _picker.getImage(
      source: source,
    );

    val = await ImageCropper.cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      maxHeight: 700,
      maxWidth: 700,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.white,
        toolbarTitle: "Bring app cropper",
      ),
    );
    print("cropper ${val.runtimeType}");
    capturedImageFile(val.path);
  }

  Future<String> uploadPic() async {
    File image = File(_imageFile);
    String fileName = image.path.split('/').last;

    var reference = _storage.ref().child("images/$this.userId/$fileName");

    //Upload the file to firebase
    UploadTask uploadTask = reference.putFile(image);

    String url;
    await uploadTask.whenComplete(() async {
      url = await uploadTask.snapshot.ref.getDownloadURL();
    });

    return url;
  }

  void saveData(BuildContext context) async {
    widget.itemDetails["price"] = double.parse(widget.itemDetails["price"]);
    await this.productService.saveProduct(widget.userId, widget.itemDetails);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              title: Text('Success'),
              content: Text('Your product saved'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/products');
                  },
                  child: Text('OK',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                )
              ],
            ));
    ;
  }
}
