import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            _goBackToPreviousPage(context);
          } ,
          child: Text('Go back!'),
        ),
      ),
    );
  }

  void _goBackToPreviousPage(BuildContext context) {

    Navigator.pop(context);

  }
}
