import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TapboxState();
}

class _TapboxState extends State<TapboxA> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: _handleTap,
      child: Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(color: _active ? Colors.lightGreen : Colors.grey),
        child: Center(
          child: Text(_active ? 'Active' : 'Inactive',
              style: TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
      ),
    );
  }

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }
}
