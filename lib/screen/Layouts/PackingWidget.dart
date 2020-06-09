import 'package:flutter/material.dart';

class PackingWidget extends StatelessWidget {
  var packedRow = Row(
    mainAxisSize:  MainAxisSize.min,
    children: <Widget>[
      Icon(
        Icons.star,
        color: Colors.green,
      ),
      Icon(
        Icons.star,
        color: Colors.green,
      ),
      Icon(
        Icons.star,
        color: Colors.green,
      ),
      Icon(
        Icons.star,
        color: Colors.black87,
      ),
      Icon(
        Icons.star,
        color: Colors.black87,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return packedRow;
  }
}
