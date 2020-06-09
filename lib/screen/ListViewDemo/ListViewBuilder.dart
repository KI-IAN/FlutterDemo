import 'package:flutter/material.dart';

class ListViewBuilder extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'I', 'J'];
  final List<int> colorCodes = <int>[100, 200, 300, 400, 500, 600, 700, 800];

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: entries.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 10,
          width: 100,
          color: Colors.amber[colorCodes[index]],
          child: Center(
            child: Text('Entry ${entries[index]}'),
          ),
        );
      },
    );

  return listView;

  }
}
