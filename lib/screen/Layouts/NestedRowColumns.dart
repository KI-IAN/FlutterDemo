import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NestedRowColumns extends StatelessWidget {
  static var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(
        Icons.star,
        color: Colors.black87,
      ),
      Icon(
        Icons.star,
        color: Colors.black87,
      ),
      Icon(
        Icons.star,
        color: Colors.black87,
      ),
      Icon(
        Icons.star,
        color: Colors.green,
      ),
      Icon(
        Icons.star,
        color: Colors.yellow,
      ),
    ],
  );

  static var reviewSection = Row(
    children: <Widget>[Text('170 Reviews!')],
  );

  static var prepSection = Container(
    padding: EdgeInsets.all(10.0),
    margin: EdgeInsets.all(12.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Icon(
        Icons.book,
        color: Colors.green,
      ),
      Text(
        'PREP',
        style: TextStyle(),
      ),
      Text(
        '25 mins',
        style: TextStyle(),
      ),
    ],
  ));

  static var cookSection = Column(
    children: <Widget>[
      Icon(
        Icons.timer,
        color: Colors.green,
      ),
      Text(
        'COOK',
        style: TextStyle(),
      ),
      Text(
        '1 hr',
        style: TextStyle(),
      ),
    ],
  );

  static var feedsSection = Column(
    children: <Widget>[
      Icon(
        Icons.local_dining,
        color: Colors.green,
      ),
      Text(
        'FEEDS',
        style: TextStyle(),
      ),
      Text(
        '4 - 6',
        style: TextStyle(),
      ),
    ],
  );

  var mainContainer = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            stars,
            reviewSection,
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[prepSection, cookSection, feedsSection],
          ),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return mainContainer;
  }
}
