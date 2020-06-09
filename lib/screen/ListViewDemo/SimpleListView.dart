import 'package:flutter/material.dart';

class SimpleListView extends StatelessWidget {
  int _totalItem = 0;
  int minColorValue = 0;
  int maxColorValue = 1000;

  @override
  Widget build(BuildContext context) {
    _totalItem = 0;

    return ListView(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
        Container(
          height: 50,
          child: Center(child: Text('Entry ${_totalItem++}')),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.amber[_totalItem * 100],
          ),
        ),
      ],
    );
  }
}
