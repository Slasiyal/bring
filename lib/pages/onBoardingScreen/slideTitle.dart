import 'package:bringseller/sizeConfig.dart';
import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {
  final String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.safeBlockHorizontal * 2.4,
        vertical: SizeConfig.safeBlockVertical * 4,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            height: SizeConfig.safeBlockVertical * 30,
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'NovaSquare',
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.safeBlockVertical * 4,
              letterSpacing: 1.0
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.3,
                fontFamily: 'light',
                color: Colors.black87.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.safeBlockVertical * 2.5
              ),
            ),
          )
        ],
      ),
    );
  }
}
