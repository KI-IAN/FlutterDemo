import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StudentModel extends ChangeNotifier {
  //region : All fields
  int _id;
  String _firstName;
  String _lastName;
  DateTime _dOB;

  String _fullName;

  double _width = 128;
  double _height = 128;
  double _radius = 8;

  Color _boxColor;

  //endRegion

  //region : Setter & Getter

  set Radius(value) => _radius = value;

  double get Radius => _radius;

  Color get BoxColor => _boxColor;

  set BoxColor(value) => _boxColor = value;

  set Width(value) {
    _width = value;
    this.InvokeChanges();
  }

  double get Width {
    return _width;
  }

  set Height(value) {
    _height = value;
    this.InvokeChanges();
  }

  double get Height {
    return _height;
  }

  set Id(int value) {
    _id = value * 3;
    this.InvokeChanges();
  }

  get Id => _id;

  set FirstName(String value) {
    _firstName = value;
    setFullName();
    this.InvokeChanges();
  }

  String get FirstName => _firstName ?? '';

  set LastName(String value) {
    _lastName = value;
    setFullName();
    this.InvokeChanges();
  }

  String get LastName => _lastName ?? '';

//endRegion

  String setFullName() {
    this._fullName = '$_firstName $_lastName';
  }

  String get FullName {
    return _fullName ?? '';
  }

  void InvokeChanges() {
    notifyListeners();
  }

  void onSubmit() {
    Id = Id * (-1);
  }

  void animateButton() {
    double minValue = 32;

    double randomValue = minValue + Random().nextDouble() * 64;
    double randomWidthValue = minValue + Random().nextDouble() * 64;
    Radius = Random().nextDouble() * 64;
    Height = randomValue;
    Width = randomWidthValue;
    BoxColor = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }
}
