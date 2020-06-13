import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page#1'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            Navigator.of(context).push(_createRoute(Page2()));
          },
        ),
      ),
    );
  }

  Route _createRoute(Widget secondPage) {
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

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => Page2(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }



}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page#2'),
      ),
      body: Center(
        child: Text('Page 2'),
      ),
    );
  }
}
