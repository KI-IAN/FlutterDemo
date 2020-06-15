import 'package:flutter/widgets.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Enums/CRUDFlagEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/ZikirViewModel.dart';

class EditZikirViewModel extends ZikirViewModel {
// #region: Fields

  CRUDFlagEnum _crudFlag = CRUDFlagEnum.Unmodified;

  int _zikirID;

  int _duaID;

  UniqueKey _zikirUniqueID = UniqueKey();

// #endRegion

// #region: Properties

  set duaID(int value) => this._duaID = value;
  int get duaID => this._duaID;

  set zikirID(int value) => this._zikirID = value;
  int get zikirID => this._zikirID;

  set crudFlag(CRUDFlagEnum value) => this._crudFlag = value;

  CRUDFlagEnum get crudFlag => this._crudFlag;

  String get crudFlagName =>
      crudFlag.toString().substring(crudFlag.toString().indexOf('.') + 1);

  UniqueKey get zikirUniqueID => this._zikirUniqueID;

// #endRegion

}
