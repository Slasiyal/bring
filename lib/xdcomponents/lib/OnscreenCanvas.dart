import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adobe_xd/pinned.dart';

class OnscreenCanvas extends StatelessWidget {
  OnscreenCanvas({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00000000),
      body: Stack(
        children: <Widget>[
          // Adobe XD layer: 'Background' (shape)
          Container(
            width: 750.0,
            height: 1334.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(''),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Adobe XD layer: 'onboad_bg' (group)
          SizedBox(
            width: 750.0,
            height: 1334.0,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 750.0, 1334.0),
                  size: Size(750.0, 1334.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'Layer 1' (shape)
                      Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(''),
                        fit: BoxFit.fill,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstIn),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(329.0, 1264.0),
            child:
                // Adobe XD layer: 'circle-dots' (group)
                SizedBox(
              width: 92.0,
              height: 12.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 12.0, 12.0),
                    size: Size(92.0, 12.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'Ellipse 4' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff333333),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(26.7, 0.0, 12.0, 12.0),
                    size: Size(92.0, 12.0),
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'Ellipse 4 copy' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(53.3, 0.0, 12.0, 12.0),
                    size: Size(92.0, 12.0),
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'Ellipse 4 copy 2' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(80.0, 0.0, 12.0, 12.0),
                    size: Size(92.0, 12.0),
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'Ellipse 4 copy 3' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(35.5, 1248.9),
            child: Text(
              'Skip',
              style: TextStyle(
                fontFamily: 'CenturyGothic-Bold',
                fontSize: 30,
                color: const Color(0xffffffff),
                letterSpacing: 3,
                height: 1.6666666666666667,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(670.0, 1251.0),
            child:
                // Adobe XD layer: 'next' (shape)
                Container(
              width: 20.0,
              height: 38.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(53.0, 276.0),
            child:
                // Adobe XD layer: 'ThirdScreen' (group)
                SizedBox(
              width: 643.0,
              height: 968.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(3.0, 0.0, 639.0, 467.0),
                    size: Size(643.3, 967.8),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Ellipse 6' (shape)
                        SvgPicture.string(
                      _svg_y81c3p,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(42.0, 53.0, 510.0, 395.0),
                    size: Size(643.3, 967.8),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'undraw_Online_shopp…' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(83.7, 616.9, 474.0, 37.0),
                    size: Size(643.3, 967.8),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'Choose your favorite things',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic-Bold',
                        fontSize: 30,
                        color: const Color(0xff000000),
                        letterSpacing: 3,
                        decoration: TextDecoration.underline,
                        height: 1.6666666666666667,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 691.7, 643.3, 276.1),
                    size: Size(643.3, 967.8),
                    pinLeft: true,
                    pinRight: true,
                    pinBottom: true,
                    fixedHeight: true,
                    child: Text(
                      'Add Products to your shopping cart, and check them out later',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 24,
                        color: const Color(0xff000000),
                        letterSpacing: 2.4000000000000004,
                        height: 2.0833333333333335,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(454.0, 333.0),
            child:
                // Adobe XD layer: 'Group 1 copy 2' (group)
                SizedBox(
              width: 19.0,
              height: 19.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 0.0, 0.0),
                    size: Size(19.0, 19.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Layer 1' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 18.9, 19.0),
                    size: Size(19.0, 19.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Group 1' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 18.9, 19.0),
                          size: Size(18.9, 19.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Rounded Rectangle 1' (shape)
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.85),
                              color: const Color(0xff333333),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(3.5, 8.4, 11.4, 8.2),
                          size: Size(18.9, 19.0),
                          pinLeft: true,
                          pinRight: true,
                          pinBottom: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Shape 2' (shape)
                              SvgPicture.string(
                            _svg_f4lzy4,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(4.7, 2.3, 9.4, 8.9),
                          size: Size(18.9, 19.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Shape 1' (shape)
                              SvgPicture.string(
                            _svg_pq19ak,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_y81c3p =
    '<svg viewBox="56.0 276.0 639.0 467.0" ><path  d="M 362.5338134765625 281.2260131835938 C 427.6632080078125 265.5783081054688 498.3858947753906 287.5199890136719 549.5712890625 312.3132019042969 C 632.1182861328125 352.2972106933594 716.9038696289063 447.7421875 689.8494873046875 518.265625 C 645.531005859375 633.7916259765625 549.6619873046875 714.2509765625 372.9247131347656 739.76171875 C 199.6972045898438 764.7659301757813 56 640.594482421875 56 518.265625 C 56 451.5483093261719 115.3142013549805 398.9928894042969 191.0827026367188 379.668701171875 C 263.78369140625 361.1268005371094 284.6672973632813 299.9338073730469 362.5338134765625 281.2260131835938 Z" fill="#f7f7f7" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_f4lzy4 =
    '<svg viewBox="3.5 8.4 11.4 8.2" ><path  d="M 13.33483219146729 10.41479682922363 C 13.92951393127441 11.55239295959473 13.78704643249512 13.36729049682617 12.21433353424072 14.28005218505859 C 10.7629280090332 15.12241077423096 7.155635356903076 14.36540126800537 6.156313419342041 13.62355518341064 C 6.156313419342041 13.62355518341064 6.426316261291504 12.54389667510986 6.426316261291504 12.54389667510986 L 3.519325494766235 13.502685546875 L 4.580277442932129 15.96557903289795 L 5.156622886657715 14.8442325592041 C 5.156622886657715 14.8442325592041 10.30283737182617 18.18479347229004 13.47294616699219 15.58970260620117 C 15.34980392456055 14.05327796936035 15.15596771240234 11.44732856750488 14.12614059448242 9.806509971618652 C 13.09807968139648 8.168506622314453 12.99940776824951 8.395476341247559 12.99940776824951 8.395476341247559 L 12.45145225524902 9.153279304504395 C 12.45145225524902 9.153279304504395 12.93013191223145 9.640627861022949 13.33483219146729 10.41479682922363 Z" fill="#fbad09" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_pq19ak =
    '<svg viewBox="4.8 2.3 9.4 8.9" ><path  d="M 12.6828145980835 8.016585350036621 C 12.9589729309082 7.118888378143311 13.11984157562256 5.459702968597412 10.7521505355835 4.431160449981689 C 7.905466556549072 3.194537878036499 6.451754570007324 3.379905939102173 6.451754570007324 3.379905939102173 L 6.490114212036133 2.301630258560181 C 6.490114212036133 2.301630258560181 11.96744537353516 2.297751665115356 13.56447887420654 5.167681217193604 C 14.53261947631836 6.907466411590576 14.24014377593994 9.070003509521484 12.65367221832275 10.1708288192749 C 11.05603504180908 11.27940368652344 9.028311729431152 11.52691173553467 6.601079940795898 10.73282718658447 C 4.173839092254639 9.938747406005859 3.761631011962891 6.820699214935303 7.646844863891602 6.655676364898682 C 10.65148258209229 6.528058052062988 12.63591766357422 8.043795585632324 12.63591766357422 8.043795585632324 C 12.63591766357422 8.043795585632324 12.68062686920166 8.023681640625 12.6828145980835 8.016585350036621 Z M 12.1839714050293 8.931266784667969 C 11.7168664932251 9.345420837402344 10.75603866577148 9.818330764770508 9.520780563354492 9.83885669708252 C 6.425209999084473 9.890280723571777 6.015667915344238 8.688991546630859 7.271360397338867 7.993295192718506 C 8.539554595947266 7.290678977966309 12.18993854522705 8.920042991638184 12.18993854522705 8.920042991638184 C 12.192138671875 8.93051815032959 12.18985080718994 8.926052093505859 12.1839714050293 8.931266784667969 Z" fill="#ffe663" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
