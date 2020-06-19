import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/AddDua/Screens/AddDuaPage.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';

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
        tooltip: getLanguageText('duaListPage_createDuaButtonToolTip'),
      );

  @override
  Widget build(BuildContext context) {
    return _buildFabButton(context);
  }
}
