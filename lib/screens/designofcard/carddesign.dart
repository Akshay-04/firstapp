import 'package:flutter/material.dart';
import 'colors.dart';
import './quadclipper.dart';

Widget card(
    {Color primary = Colors.redAccent,
    String chipText1 = '',
    String chipText2 = '',
    Widget backWidget,
    Color chipColor = LightColor.orange,
    @required double widths}) {
  widths = widths * .4;
  return Container(
      height: 250,
      width: widths,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          color: primary.withAlpha(200),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 10,
                color: LightColor.lightpurple.withAlpha(20))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: Stack(
            children: <Widget>[
              backWidget,
              Positioned(
                bottom: 10,
                left: 10,
                child: _cardInfo(chipText1, chipText2,
                    LightColor.titleTextColor, chipColor, widths),
              )
            ],
          ),
        ),
      ));
}

Widget _cardInfo(String title, String courses, Color textColor, Color primary,
    double width) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10),
          width: 200,
          alignment: Alignment.topCenter,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(height: 5),
        _chip(courses, primary, height: 5)
      ],
    ),
  );
}

Widget _chip(String text, Color textColor, {double height = 0}) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      color: textColor.withAlpha(200),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.black),
    ),
  );
}

Widget decorationContainerA(Color primary, double top, double left) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: primary.withAlpha(255),
        ),
      ),
      smallContainer(primary, 20, 40),
      Positioned(
        top: 20,
        right: -30,
        child: circularContainer(80, Colors.transparent,
            borderColor: Colors.white),
      )
    ],
  );
}

Widget decorationContainerB(Color primary, double top, double left) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -65,
        right: -65,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.blue.shade100,
          child: CircleAvatar(radius: 30, backgroundColor: primary),
        ),
      ),
      Positioned(
          top: 35,
          right: -40,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(
                  backgroundColor: LightColor.lightseeBlue, radius: 40)))
    ],
  );
}

Widget decorationContainerC(Color primary, double top, double left) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -105,
        left: -35,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: LightColor.orange.withAlpha(100),
        ),
      ),
      Positioned(
          top: 35,
          right: -40,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(
                  backgroundColor: LightColor.orange, radius: 40))),
      smallContainer(
        LightColor.yellow,
        35,
        70,
      )
    ],
  );
}

Widget decorationContainerD(Color primary, double top, double left,
    {Color secondary, Color secondaryAccent}) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: secondary,
        ),
      ),
      smallContainer(LightColor.yellow, 18, 35, radius: 12),
      Positioned(
        top: 130,
        left: -50,
        child: CircleAvatar(
          radius: 80,
          backgroundColor: primary,
          child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
        ),
      ),
      Positioned(
        top: -30,
        right: -40,
        child: circularContainer(80, Colors.transparent,
            borderColor: Colors.white),
      )
    ],
  );
}

Widget decorationContainerE(Color primary, double top, double left,
    {Color secondary}) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -105,
        left: -35,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: primary.withAlpha(100),
        ),
      ),
      Positioned(
          top: 40,
          right: -25,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(backgroundColor: primary, radius: 40))),
      Positioned(
          top: 45,
          right: -50,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(backgroundColor: secondary, radius: 50))),
      smallContainer(LightColor.yellow, 15, 90, radius: 5)
    ],
  );
}

Widget decorationContainerF(
    Color primary, Color secondary, double top, double left) {
  return Stack(
    children: <Widget>[
      Positioned(
          top: 25,
          right: -20,
          child: RotatedBox(
            quarterTurns: 1,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: primary.withAlpha(100), radius: 50)),
          )),
      Positioned(
          top: 34,
          right: -8,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(
                  backgroundColor: secondary.withAlpha(100), radius: 40))),
      smallContainer(LightColor.yellow, 15, 90, radius: 5)
    ],
  );
}

Positioned smallContainer(Color primary, double top, double left,
    {double radius = 10}) {
  return Positioned(
      top: top,
      left: left,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: primary.withAlpha(255),
      ));
}

Widget circularContainer(double height, Color color,
    {Color borderColor = Colors.transparent, double borderWidth = 2}) {
  return Container(
    height: height,
    width: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
    ),
  );
}

List<Map<String, Object>> listofcontainers = [{
  'primary': LightColor.orange,
                'backWidget':
                    decorationContainerA(LightColor.lightOrange, 50, -30),
                'chipColor': LightColor.orange,
},
{ 'primary': Colors.white,
                'chipColor': LightColor.seeBlue,
                'backWidget': decorationContainerB(Colors.white, 90, -40)},
                {
                   'primary': Colors.white,
                'chipColor': LightColor.seeBlue,
                'backWidget': decorationContainerB(Colors.white, 90, -40)
                },
                {
                'primary': Colors.white,
                'chipColor': LightColor.seeBlue,
                'backWidget': decorationContainerD(LightColor.seeBlue, -50, 30,
                    secondary: LightColor.lightseeBlue,
                    secondaryAccent: LightColor.darkseeBlue)
                },
                {
                  'primary': LightColor.seeBlue,
                'chipColor': LightColor.seeBlue,
                'backWidget': decorationContainerD(
                    LightColor.darkseeBlue, -100, -65,
                    secondary: LightColor.lightseeBlue,
                    secondaryAccent: LightColor.seeBlue)
                },
                 {'primary': Colors.white,
                'chipColor': LightColor.lightpurple,
                'backWidget': decorationContainerE(
                  LightColor.lightpurple,
                  90,
                  -40,
                  secondary: LightColor.lightseeBlue,
                ),
                },
                {
                  'primary': Colors.white,
                'chipColor': LightColor.lightOrange,
                'backWidget': decorationContainerF(
                    LightColor.lightOrange, LightColor.orange, 50, -30)}
                ];
