import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/ListViewDemo/ListViewBuilder.dart';

class ListViewSeparator extends ListViewBuilder {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: Center(
            child: Text('Entry ${entries[index]}'),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: entries.length,
    );
  }
}
