import 'package:flutter/foundation.dart';
import 'package:fluttertutorial/Apps/DuaTracker/DummyData/DataRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Enums/CRUDFlagEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditZikirViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';

class EditDuaPageViewModel extends BaseViewModel {
// #region : Fields

  EditDuaViewModel _dua;

  List<EditZikirViewModel> _zikirDBList;

  List<EditZikirViewModel> _zikirUIList;

  int _totalZikirsInDBList = 0;

  int _totalZikirsInUIList = 0;

  EditZikirViewModel _temporaryZikirData;

// #endRegion

// #region : Properties

  set temporaryZikirData(EditZikirViewModel value) {
    this._temporaryZikirData = value;
  }

  EditZikirViewModel get temporaryZikirData => this._temporaryZikirData;

  set dua(EditDuaViewModel value) {
    this._dua = value;
  }

  EditDuaViewModel get dua => this._dua;

  set zikirDBList(List<EditZikirViewModel> value) {
    this._zikirDBList = value;
    // this.InvokeChanges();
  }

  List<EditZikirViewModel> get zikirDBList => this._zikirDBList;

  set zikirUIList(List<EditZikirViewModel> value) {
    this._zikirUIList = value;
    // this.InvokeChanges();
  }

  List<EditZikirViewModel> get zikirUIList => this._zikirUIList;

  int get totalZikirsInUIList {
    this._totalZikirsInUIList = zikirUIList.length;
    return this._totalZikirsInUIList;
  }

  set totalZikirsInUIList(int value) {
    this._totalZikirsInUIList = value;
    this.InvokeChanges();
  }

  int get totalZikirsInDBList {
    this._totalZikirsInDBList = zikirDBList.length;
    return this._totalZikirsInDBList;
  }

  set totalZikirsInDBList(int value) {
    this._totalZikirsInDBList = value;
    this.InvokeChanges();
  }

// #endRegion

// #region : Constructors

  EditDuaPageViewModel(@required int duaID) {
    var data = DummyDataRepository();

    _dua = data.getDua(duaID);
    var zikirs = data.getZikirs(duaID);

    _zikirDBList = zikirs;
    _zikirUIList = zikirs.toList();

    // _zikirDBList = data.getZikirs(duaID);
    // _zikirUIList = data.getZikirs(duaID);
  }

// #endRegion

// #region : Event Handler Functions

  void updateZikir() {
//Update data in both UIList & DBList
    var selectedDataIndexUIList = zikirUIList.indexWhere(
        (element) => element.zikirUniqueID == temporaryZikirData.zikirUniqueID);

    var selectedDataIndexDBList = zikirDBList.indexWhere(
        (element) => element.zikirUniqueID == temporaryZikirData.zikirUniqueID);

    var itemExistInDB = temporaryZikirData.crudFlag != CRUDFlagEnum.New;

    //Update data in DBList
    if (itemExistInDB) {
      zikirDBList.elementAt(selectedDataIndexDBList).crudFlag =
          CRUDFlagEnum.Modified;
    }
    zikirDBList.elementAt(selectedDataIndexDBList)
      ..zikirName = temporaryZikirData.zikirName
      ..numberOfTimesWantToRead = temporaryZikirData.numberOfTimesWantToRead
      ..numberOfTimesRead = temporaryZikirData.numberOfTimesRead;

    //Update data in UIList
    zikirUIList.elementAt(selectedDataIndexUIList)
      ..zikirName = temporaryZikirData.zikirName
      ..numberOfTimesWantToRead = temporaryZikirData.numberOfTimesWantToRead
      ..numberOfTimesRead = temporaryZikirData.numberOfTimesRead;

    //force update the list view
    totalZikirsInUIList = zikirUIList.length;
  }

  void addNewZikir() {
    this.temporaryZikirData.crudFlag = CRUDFlagEnum.New;

    zikirUIList.add(this.temporaryZikirData);
    totalZikirsInUIList = zikirUIList.length;

    zikirDBList.add(this.temporaryZikirData);
    totalZikirsInDBList = zikirDBList.length;
  }

  void removeZikirFromList(int index) {
    // zikirs.removeAt(index);
    // totalZikirs = zikirs.length;

    //remove from UIList
    var deletedItem = zikirUIList.removeAt(index);
    totalZikirsInUIList = zikirUIList.length;

    //Then remove from DBList if it is newly created and does not exist in DB
    var deletedItemInDBList = zikirDBList.firstWhere(
        (element) => element.zikirUniqueID == deletedItem.zikirUniqueID);

    //When zikir is newly creted, but does not exist in database
    //delete the item from zikirDBList
    bool itemNotExistInDB = deletedItemInDBList.crudFlag == CRUDFlagEnum.New;

    if (itemNotExistInDB) {
      zikirDBList.remove(deletedItemInDBList);
      totalZikirsInDBList = zikirDBList.length;
    } else {
      //seleted item already exist in DBList.
      //In that case, we need to update CRUDFlag to Deleted.
      zikirDBList
          .firstWhere((element) =>
              element.zikirUniqueID == deletedItemInDBList.zikirUniqueID)
          .crudFlag = CRUDFlagEnum.Deleted;
      totalZikirsInDBList = zikirDBList.length;
    }
  }

  void updateDatabase() {
    // var testCall = 10;
  }

// #endRegion

// #region : Other Functions

// #endRegion

// #region : Dummy Data (Delete when real data is available)

// #endRegion

}
