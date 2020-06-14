import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/SlideDirectionEnum.dart';

class PageTransition {
  Route createRoute(Widget secondPage, [SlideDirectionEnum slideDirection]) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => secondPage,
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = Offset(1.0, 0.0);

        if (slideDirection == SlideDirectionEnum.Right) {
          begin = Offset(1.0, 0.0);
        } else if (slideDirection == SlideDirectionEnum.Left) {
          begin = Offset(-1.0, 0.0);
        } else if (slideDirection == SlideDirectionEnum.Top) {
          begin = Offset(0.0, -1.0);
        } else if (slideDirection == SlideDirectionEnum.Bottom) {
          begin = Offset(0.0, 1.0);
        }

        var end = Offset.zero;

        var curve = Curves.ease;

        // var curveTween = CurveTween(curve: curve);
        // var tween = Tween(begin: begin, end: end).chain(curveTween);
        // var offsetAnimation = animation.drive(tween);

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

        return SlideTransition(
          // position: offsetAnimation,
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
