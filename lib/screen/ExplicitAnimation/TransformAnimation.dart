import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';

class TransformAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transform Animation'),
        backgroundColor: randomColor(),
      ),
      body: TransformAnimation(),
    );
  }
}

class TransformAnimation extends StatefulWidget {
  @override
  State<TransformAnimation> createState() => TransformWidget();
}

class TransformWidget extends State<TransformAnimation>
    with SingleTickerProviderStateMixin {
  var buttonRotation = 0.0;
  var iconSize = 120.0;
  var maxRotation = 20.0;

  Animation<double> animation;
  AnimationController controller;

  AnimationController controller_2;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // controller_2 = AnimationController(
    //   duration: const Duration(milliseconds: 1000),
    //   vsync: this,
    // );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildLikeButton() => Center(
        child: RotationTransition(
          turns: animation,
          child: IconButton(
            iconSize: iconSize,
            icon: Icon(Icons.thumb_up),
            onPressed: () {
              controller.forward(from: 0.2);
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildLikeButton(),
        _buildLikeButton(),
      ],
    );
  }
}
