import 'dart:math';

import 'package:flutter/material.dart';

class EditDuaPageStyles {

  static Color randomColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }

  static TextStyle dataLabelTextStyle() =>
      TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle captionLabelTextStyle() =>
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle secondaryCaptionTextStyle() =>
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);

  static OutlineInputBorder textFieldBorderStyle() => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        borderSide: BorderSide(color: Colors.lightBlue),
      );


}
