import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/ZikirViewModel.dart';

class AddDuaViewModel extends BaseViewModel {
//region : Fields

  DuaViewModel _dua;
  List<ZikirViewModel> _zikirs;
  int _totalZikirs = 0;

//endRegion

//region: Properties
  set dua(DuaViewModel value) {
    this._dua = value;
  }

  DuaViewModel get dua => this._dua;

  set zikirs(List<ZikirViewModel> value) {
    this._zikirs = value;
  }

  List<ZikirViewModel> get zikirs => this._zikirs;

  int get totalZikirs {
    this._totalZikirs = zikirs.length;
    return this._totalZikirs;
  }

  set totalZikirs(int value) {
    this._totalZikirs = value;
    notifyListeners();
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
    // notifyListeners();
  }

  void removeZikirFromList(int index) {
    zikirs.removeAt(index);
    totalZikirs = zikirs.length;
    // notifyListeners();
  }

//endRegion

}
