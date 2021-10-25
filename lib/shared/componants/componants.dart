import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

Future<dynamic> navigateTo({
  required BuildContext context,
  required Widget screen,
  bool leftToRightTransasion = false,
}) {
  if (!leftToRightTransasion)
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  else
    return Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            duration: Duration(milliseconds: 300),
            child: screen));
}

Future<dynamic> navigateAndfinish({
  required BuildContext context,
  required Widget screen,
  bool rightToLeftTransasion = false,
}) {
  if (!rightToLeftTransasion)
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  else
    return Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            child: screen));
}

Widget buildLoginBottom({
  required String title,
  required Function() onPressed,
}) =>
    Center(
      child: Container(
        width: 250.0,
        height: 50.0,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          color: Colors.blueGrey,
        ),
      ),
    );

Widget buildVisibleBottom({
  required String title,
  required Function() onPressed,
  required bool isVisible,
  required double width,
  required double height,
}) =>
    Visibility(
      visible: isVisible,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 15.0),
          width: width,        //180.0,
          height:height ,        //50.0,
          child: MaterialButton(
            onPressed: onPressed,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: Colors.teal,
          ),
        ),
      ),
    );

Widget buildDrawerItem({
  required String title,
  required Function() onTap,
}) =>
    Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
      child: InkWell(
        splashColor: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                size: 40.0,
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );

Widget buildVisibleDrawerItem({
  required String title,
  required Function() onPressed,
  required bool isVisible,
}) =>
    Visibility(
      visible: isVisible,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        height: 40.0,
        width: 10.0,
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5.0,
          ),
          color: Colors.blueGrey,
        ),
      ),
    );
