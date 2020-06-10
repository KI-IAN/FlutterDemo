import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';

class DuaViewModel extends BaseViewModel {
//region : Fields

  String _name;
  DateTime _creationDateTime;

//endRegion

//region: Properties
  set name(String value) {
    this._name = value;
  }

  String get name => this._name;

  set creationDateTime(DateTime value) {
    this._creationDateTime = value;
  }

  DateTime get creationDateTime => this._creationDateTime;

//endRegion

}
