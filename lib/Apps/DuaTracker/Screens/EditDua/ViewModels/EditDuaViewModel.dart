

import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Enums/CRUDFlagEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaViewModel.dart';

class EditDuaViewModel extends DuaViewModel{


// #region: Fields

CRUDFlagEnum _crudFlag = CRUDFlagEnum.Unmodified;

int _duaID;

// #endRegion


// #region: Properties

set crudFlag(CRUDFlagEnum value) => this._crudFlag = value;

CRUDFlagEnum get crudFlag => this._crudFlag;


set duaID(int value) => this._duaID = value;

int get duaID => this._duaID;

// #endRegion



}