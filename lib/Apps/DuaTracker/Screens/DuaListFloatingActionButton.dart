import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/AddDuaPage.dart';

class DuaListFloatingActionButton extends StatelessWidget {
  Widget _buildFabButton(BuildContext context) => FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(PageTransition().createRoute(AddDuaPage()));
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
