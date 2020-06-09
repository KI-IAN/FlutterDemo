import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';

class CircularTextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Texxt'),
        centerTitle: true,
      ),
      body: CircularTextDemo(),
    );
  }
}

class CircularTextDemo extends StatelessWidget {
  Widget _buildCircularText() {
    return CircularText(
      text: Text(
        'স্তবক Delete',
        style: TextStyle(
            color: Colors.blue, fontSize: 15, fontFamily: 'Atma'),
      ),
      radius: 25,
      space: 15,
      startAngle: 240,
      backgroundPaint: Paint()..color = Colors.grey.shade200,
      position: CircularTextPosition.outside,
      direction: CircularTextDirection.clockwise,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: _buildCircularText());
  }
}
