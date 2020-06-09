import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/Layouts/GridViewDemos.dart';

class CustomShapeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: ArcPainter(),
        // child: GridViewDemo(),
        child: Center(
          child: Transform.rotate(
            angle: 270.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'মচ',
                  style: TextStyle(
                    fontFamily: 'Atma',
                    fontSize: 100,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.blueAccent[500],
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  'ৎ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Atma',
                    fontSize: 200,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.blueAccent[500],
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  'কার',
                  style: TextStyle(
                    fontFamily: 'Atma',
                    fontSize: 100,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.blueAccent[500],
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[500];
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);

    //Bottom Arc
    paint.color = Colors.lightBlueAccent[200];
    paint.style = PaintingStyle.fill;

    var path_2 = Path();

    path_2.moveTo(0, size.height * 0.9167);
    path_2.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path_2.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path_2.lineTo(size.width, size.height);
    path_2.lineTo(0, size.height);

    canvas.drawPath(path_2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green[500];
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    var path = Path();
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
