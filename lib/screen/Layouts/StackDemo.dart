import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  Widget _buildStack() => Stack(
        alignment: const Alignment(0.6, 0.6),
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/pic0.jpg'),
            radius: 100,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
            child: Text(
              'Nuva',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            // alignment: Alignment(0.3, 0.3),
              child: Icon(
            Icons.add_a_photo,
            color: Colors.green,
          ))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _buildStack();
  }
}
