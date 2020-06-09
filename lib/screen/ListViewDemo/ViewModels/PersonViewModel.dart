

class PersonViewModel {


  String _firstName;

  String _lastName;

  int _age;

  bool _isCareless;


  set FirstName(String value) {
    _firstName = value;
  }

  set LastName(String value){
    _lastName = value;
  }


  set Age(int value){
    _age = value;
  }


  set IsCareLess(bool value){
    _isCareless = value;
  }


  String get FirstName => this._firstName;

  String get LastName => this._lastName;

  int get Age => this._age;

  bool get IsCareLess => this._isCareless;


}