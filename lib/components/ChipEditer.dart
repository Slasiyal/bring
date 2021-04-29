import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ChipEditorPressedCallBack = void Function(int index);

class ChipEditor extends StatelessWidget {
  final ChipEditorPressedCallBack onPressed;
  final index;
  ChipEditor({Key key, this.onPressed, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.blue,
      focusColor: Colors.black,
      hoverColor: Colors.black,
        icon: Icon(Icons.close,color: Colors.white,size: 16,),
        onPressed: () {
          if (onPressed != null) onPressed(this.index);
        });
  }
}
