import 'package:fluttertutorial/screen/MVVMTest/Interfaces/INotifyPropertyChanged.dart';
import 'package:fluttertutorial/screen/MVVMTest/StudentPage.dart';
import 'package:fluttertutorial/screen/MVVMTest/ViewModel/BaseViewModel.dart';

class StudentViewModel extends BaseViewModel {
  //region : All fields
  int _id;
  String _firstName;
  String _lastName;
  DateTime _dOB;

  String _fullName;
  //endRegion

  //region : Constructor

  INotifyPropertyChanged _widget;

  StudentViewModel(this._widget) : super(_widget);

  //endRegion

  //region : Setter & Getter

  set Id(int value) {
    _id = value;
    this.RefreshUI();
  }

  get Id => _id;

  set FirstName(String value) {
    _firstName = value;
    setFullName();
    this.RefreshUI();
  }

  String get FirstName => _firstName ?? '';

  set LastName(String value) {
    _lastName = value;
    setFullName();
    this.RefreshUI();
  }

  String get LastName => _lastName ?? '';

//endRegion

  String setFullName() {
    this._fullName = '$_firstName $_lastName';
  }

  String get FullName {
    return _fullName ?? '';
  }


}
