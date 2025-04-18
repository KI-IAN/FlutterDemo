import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: RaisedButton(
          onPressed: _increment,
          child: Text('Increment'),
        )),
        Expanded(child: Text('Count : $_counter')),
      ],
    );
  }
}
