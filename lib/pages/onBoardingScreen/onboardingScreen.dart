import 'package:bringseller/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:bringseller/pages/onBoardingScreen/slideTitle.dart';
import 'package:bringseller/pages/onBoardingScreen/sliderModel.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<SliderModel> slides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 7.0,
      width: isCurrentPage ? 10.0 : 7.0,
      decoration: BoxDecoration(
          color: isCurrentPage ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(12)),
    );
  }

  buildSlides() {
    slides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    buildSlides();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffbc109),
        elevation: 0,
        toolbarHeight: 0,
        leading: Container(),
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Skip',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/onBoarding/onboad_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 50,
                left: 0,
                child: Container(
                  width: SizeConfig.screenWidth,
                  child: Center(
                      child: Image.asset(
                    "assets/loghori.png",
                    width: SizeConfig.screenWidth * 0.50,
                  )),
                )),
            Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Row(children: [
                            for (int i = 0; i < 3; i++)
                              i == slideIndex
                                  ? _buildPageIndicator(true)
                                  : _buildPageIndicator(false),
                          ]),
                        ),
                      ],
                    ),
                  ),
                )),
            PageView(
              controller: this.controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
              children: <Widget>[
                SlideTile(
                  imagePath: slides[0].getImageAssetPath(),
                  title: slides[0].getTitle(),
                  desc: slides[0].getDesc(),
                ),
                SlideTile(
                  imagePath: slides[1].getImageAssetPath(),
                  title: slides[1].getTitle(),
                  desc: slides[1].getDesc(),
                ),
                SlideTile(
                  imagePath: slides[2].getImageAssetPath(),
                  title: slides[2].getTitle(),
                  desc: slides[2].getDesc(),
                )
              ],
            ),
            Positioned(
              child: FlatButton(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 35.0,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    if (slideIndex != 2) {
                      controller.animateToPage(slideIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.linear);
                    } else {
                      Navigator.of(context).pushReplacementNamed('/');
                    }
                  }),
              right: 10,
              bottom: 10,
            ),
            Positioned(
              child: FlatButton(
                  child: Text("Skip",
                      style: TextStyle(
                          height: 1.3,
                          color: Colors.white,
                          fontFamily: 'Normal',
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.safeBlockVertical * 2.3)),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  }),
              left: 10,
              bottom: 10,
            )
          ],
        ),
      ),
    );
  }
}
