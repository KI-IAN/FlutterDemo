import 'dart:math';

import 'package:flutter/material.dart';

List<int> list = [1, 2, 3, 4, 5, 6, 7, 8];

class AnimatedListApp extends StatelessWidget {
  var animatedList = AnimatedListDemoState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedListDemo(),
    );
  }
}

class AnimatedListDemo extends StatefulWidget {
  @override
  AnimatedListDemoState createState() => AnimatedListDemoState();
}

class AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Widget incrementerButton() => Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    var newNumber = Random().nextInt(10000);
                    list.add(newNumber);
                    _listKey.currentState.insertItem(list.length - 1);
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
                icon: Icon(Icons.delete_forever),
                onPressed: () {
                  setState(() {
                    if (list.length > 0) {
                      list.removeLast();
                      _listKey.currentState.removeItem(
                          list.length - 1,
                          (context, animation) => Padding(
                                padding: EdgeInsets.all(10.0),
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  child: Card(
                                    child: Text('Item#'),
                                  ),
                                ),
                              ));
                    }
                  });
                }),
          ),
        ],
      );

  Widget animatedList() => AnimatedList(
        key: _listKey,
        initialItemCount: list.length,
        itemBuilder: (context, index, animation) {
          return _buildListItem(animation, index);
        },
      );

  Padding _buildListItem(Animation<double> animation, int index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: Text('Item#${list.elementAt(index)}'),
        ),
      ),
    );
  }

  Widget _buildWidget() => Column(
        children: <Widget>[
          incrementerButton(),
          Expanded(
            child: animatedList(),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }
}
