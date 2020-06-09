import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  int _buttonTapCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _incrementCounter();
        print('MyButton was tapped!!');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen,
        ),
        child: Center(
          child: Text('Clicked : $_buttonTapCount time${_buttonTapCount > 0 ? 's': ''}'),
        ),
      ),
    );
  }

  void _incrementCounter(){
    _buttonTapCount++;
  }

}
