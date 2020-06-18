import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';

class DuaListViewModel extends BaseViewModel {
//region : Fields
  String _duaName;

  int _duaID;

  int _totalZikirs;

  int _totalZikirsRead;

  int _totalNumberOfTimesZikirToBeRead;

  int _totalNumberOfTimesZikirRead;

//endRegion

//region : Properties

  set duaName(String value) {
    _duaName = value;
  }

  String get duaName => _duaName;

  set duaID(int value) {
    _duaID = value;
  }

  int get duaID => _duaID;

  set totalZikirs(int value) {
    _totalZikirs = value;
  }

  int get totalZikirs => _totalZikirs;

  set totalZikirsRead(int value) {
    _totalZikirsRead = value;
  }

  int get totalZikirsRead => _totalZikirsRead;

  set totalNumberOfTimesZikirToBeRead(int value) {
    _totalNumberOfTimesZikirToBeRead = value;
  }

  int get totalNumberOfTimesZikirToBeRead => _totalNumberOfTimesZikirToBeRead;

  set totalNumberOfTimesZikirRead(int value) {
    _totalNumberOfTimesZikirRead = value;
  }

  int get totalNumberOfTimesZikirRead => _totalNumberOfTimesZikirRead;

//endRegion






//region : Event Handler



//endRegion

}
