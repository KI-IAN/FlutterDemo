import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NonMaterialApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(color: Colors.white),

      child: Center(
        child: Text(
          'Hello Non-material App!!',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),

        ),
      ),

    );
  }


}