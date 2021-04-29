import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Theme.Const.dart';

typedef TagButtonPressedCallBack = void Function(int index);

class TagButton extends StatelessWidget {
  final TagButtonPressedCallBack onPressed;
  final index;
  TagButton({Key key, this.onPressed, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -6,
      right: -20,
      child: IconButton(
        color: Colors.blue,
        focusColor: Colors.black,
        hoverColor: Colors.black,
          icon: Icon(Icons.close,color:Colors.white,size: 16,),
          onPressed: () {
            if (onPressed != null) onPressed(this.index);
          }),
    );
  }
}
