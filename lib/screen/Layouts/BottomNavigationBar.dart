import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Bottom Navigation Bar...'),
        ),
        body: BottomNavigationBarDemo(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          backgroundColor: Colors.lightBlue,
          hoverColor: Colors.lightGreen,
          hoverElevation: 10,
          child: Icon(Icons.lightbulb_outline),
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.amber,
            
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text('Message'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), title: Text(''))
            ]));
  }
}

class BottomNavigationBarDemo extends StatelessWidget {
  Widget _textContent() => Container(
        child: Text(
          'Hello Flutter Layouts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      );

  Widget _completeLayout() => Container(
        child: Column(
          children: <Widget>[
            Center(
              child: _textContent(),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _completeLayout();
  }
}
