import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class GridViewDemo extends StatelessWidget {
  Widget _buildGrid() => GridView.extent(
        maxCrossAxisExtent: 150,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        children: _buildGridTileList(30),
      );

  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (index) => Container(
            child: Image.asset('images/pic$index.jpg'),
          ));

  @override
  Widget build(BuildContext context) {
    return _buildGrid();
  }
}
