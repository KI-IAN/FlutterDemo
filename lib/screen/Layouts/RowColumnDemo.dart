import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RowDemo(),
//        ColumnDemo(),
      ],
    );
  }
}

class RowDemo extends StatelessWidget {
  var imageRows = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(child: Image.asset('images/pic1.jpg')),
      Expanded(
        child: Image.asset('images/pic2.jpg'),
        flex: 3,
      ),
      Expanded(child: Image.asset('images/pic3.jpg')),
//      Expanded(child: Image.asset('lib/images/lake.jpg'))
    ],
  );

  @override
  Widget build(BuildContext context) {
    return imageRows;
  }
}

class ColumnDemo extends StatelessWidget {
  var imageColumns = Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Image.asset('images/pic1.jpg'),
      Image.asset('images/pic2.jpg'),
      Image.asset('images/pic3.jpg'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return imageColumns;
  }
}
