import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Dua.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/ZikirViewModel.dart';

class AddDuaViewModel extends BaseViewModel {
//region : Fields

  DuaViewModel _dua;
  List<ZikirViewModel> _zikirs;
  int _totalZikirs = 0;

  ZikirViewModel _temporaryZikirData;

//endRegion

//region: Properties

  set temporaryZikirData(ZikirViewModel value) {
    this._temporaryZikirData = value;
  }

  ZikirViewModel get temporaryZikirData => this._temporaryZikirData;

  set dua(DuaViewModel value) {
    this._dua = value;
  }

  DuaViewModel get dua => this._dua;

  set zikirs(List<ZikirViewModel> value) {
    this._zikirs = value;
    // this.InvokeChanges();
  }

  List<ZikirViewModel> get zikirs => this._zikirs;

  int get totalZikirs {
    this._totalZikirs = zikirs.length;
    return this._totalZikirs;
  }

  set totalZikirs(int value) {
    this._totalZikirs = value;
    this.InvokeChanges();
  }

//endRegion

//region: Constructor

  AddDuaViewModel() {
    dua = DuaViewModel();
    zikirs = List<ZikirViewModel>();
  }

//endRegion

//region : Event Handler

  void addNewZikirInList() {
    zikirs.add(ZikirViewModel());
    totalZikirs = zikirs.length;
  }

  void removeZikirFromList(int index) {
    zikirs.removeAt(index);
    totalZikirs = zikirs.length;
  }

  void addNewZikir() {
    zikirs.add(this.temporaryZikirData);
    totalZikirs = zikirs.length;
  }

//endRegion


// #region : Data Access

void addDuaInDB(){

DuaRepository duaRepo = DuaRepository();

duaRepo.insert(Dua(name: dua.name));


}

// #endRegion

}
