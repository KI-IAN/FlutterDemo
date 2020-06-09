import 'package:flutter/material.dart';

class CompleteLayout extends StatelessWidget {
//region: Individual Widgets

  static String hillImageURL = 'images/hills.jpg';
  static int _loveCount = 41;

  static var coverPhoto = Row(
    children: <Widget>[
      Expanded(child: Image.asset('$hillImageURL')),
    ],
  );

  static var topicTitle = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Oeschinen Lake Campground',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          Text(
            'Kandersteg, Switzerland',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      Icon(Icons.star, color: Colors.red[600]),
      Text('$_loveCount'),
    ],
  );

  static var buttonSection = Container(
    margin: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _iconButton(Icons.phone, 'CALL'),
        _iconButton(Icons.directions, 'ROUTE'),
        _iconButton(Icons.share, 'SHARE')
      ],
    ),
  );

  static var description = Container(
    padding: EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Oeschinen Lake (German: Oeschinensee) is a lake in the Bernese Oberland, Switzerland,'
            ' 4 kilometres (2.5 mi) east of Kandersteg in the Oeschinen valley. At an elevation of '
            '1,578 metres (5,177 ft), it has a surface area of 1.1147 square kilometres (0.4304 sq mi). '
            'Its maximum depth is 56 metres (184 ft).The lake is fed through a series of mountain creeks '
            'and drains underground. The water then resurfaces as the Oeschibach. '
            'Part of it is captured for electricity production and as water supply for Kandersteg.'
            'In observations from 1931 to 1965, the elevation of the lake surface varied between '
            '1,566.09 metres (5,138.1 ft) and 1,581.9 metres (5,190 ft). The average seasonal variation was 12.2 metres'
            '(40 ft) (September/April).',
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.w300, fontFamily: 'Roboto'),
          ),
        )
      ],
    ),
  );

  static var fullLayout = 
  Column(
    children: <Widget>[
      coverPhoto,
      SizedBox(height: 10),
      topicTitle,
      SizedBox(height: 10),
      buttonSection,
      SizedBox(height: 10),
      description,
    ],
  );

  static Widget _iconButton(IconData icon, String iconTitle) {
    var iconButton = Container(
      child: Column(
        children: <Widget>[
          Icon(icon, color: Colors.blue[600]),
          SizedBox(height: 10),
          Text(
            '$iconTitle',
            style:
                TextStyle(color: Colors.blue[600], fontWeight: FontWeight.w400),
          )
        ],
      ),
    );

    return iconButton;
  }

//endregion

  @override
  Widget build(BuildContext context) {
    return fullLayout;
  }
}
