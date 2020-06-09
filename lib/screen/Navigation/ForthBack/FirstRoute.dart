import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/Navigation/ForthBack/SecondRoute.dart';

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('First Route'),
//      ),
      body:
      Center(
        child: RaisedButton(
          child: Text('Open Route'),
          onPressed: () {
            _OpenRoute(context);
          },
        ),
      ),
    );
  }

  void _OpenRoute(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondRoute()));
  }
}
