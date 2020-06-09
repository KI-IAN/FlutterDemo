import 'package:flutter/material.dart';

class ConstraintsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Example1_FullSizeContainer();
  }
}

class Example1_FullSizeContainer extends StatelessWidget {
  Widget _buildExample1() => Container(
        color: Colors.red,
      );

  Widget _buildExample2() => Container(
        color: Colors.green,
        width: 100,
        height: 100,
      );
//ss
  Widget _buildExample3() => Center(
        child: Container(
          color: Colors.blueAccent,
          width: 200,
          height: 200,
        ),
      );

  Widget _buildExample4() => Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      );

  Widget _buildExample5() => Center(
        child: Container(
          color: Colors.green,
          width: double.infinity,
          height: double.infinity,
        ),
      );

  Widget _buildExample8() => Center(
        child: Container(
          color: Colors.red,
          padding: EdgeInsets.all(30.0),
          child: Container(
            color: Colors.green,
            width: 30,
            height: 30,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildExample8();
  }
}
