import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/TapBox/TapBoxA.dart';

class MyTapBoxAApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: TapboxA(),
        ),
      ),
    );
  }
}
