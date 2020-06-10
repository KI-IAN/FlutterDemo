import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';

class ZikirViewModel extends BaseViewModel {
//region: Fields

  String _zikirName = '';
  int _numberOfTimesRead = 0;
  int _numberOfTimesWantToRead = 0;
  DateTime _duaCreationDateTime = DateTime.now();

//endRegion

//region : Properties

  set zikirName(String value) {
    this._zikirName = value;
    InvokeChanges();
  }

  String get zikirName => _zikirName;

  set numberOfTimesRead(int value) {
    this._numberOfTimesRead = value;
    InvokeChanges();
  }

  int get numberOfTimesRead => _numberOfTimesRead;

  set numberOfTimesWantToRead(int value) {
    this._numberOfTimesWantToRead = value;
    InvokeChanges();
  }

  int get numberOfTimesWantToRead => _numberOfTimesWantToRead;

  set duaCreationDateTime(DateTime value) {
    this._duaCreationDateTime = value;
    InvokeChanges();
  }

  DateTime get duaCreationDateTime => _duaCreationDateTime;

//endRegion

}
