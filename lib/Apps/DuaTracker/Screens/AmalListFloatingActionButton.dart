import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/AddDuaPage.dart';

class AmalListFloatingActionButton extends StatelessWidget {
  Widget _buildFabButton(BuildContext context) => FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddDuaPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.lightGreen,
        tooltip: 'নতুন আমলের তথ্য বানাই',
      );

  @override
  Widget build(BuildContext context) {
    return _buildFabButton(context);
  }
}
