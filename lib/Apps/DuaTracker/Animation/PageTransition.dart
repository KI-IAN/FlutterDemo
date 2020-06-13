

import 'package:flutter/material.dart';

class PageTransition{


  Route createRoute(Widget secondPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => secondPage,
      // transitionDuration: Duration(seconds: 5),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;

        var curve = Curves.ease;

        // var curveTween = CurveTween(curve: curve);
        // var tween = Tween(begin: begin, end: end).chain(curveTween);
        // var offsetAnimation = animation.drive(tween);

        var tween = Tween(begin: begin, end:end);
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