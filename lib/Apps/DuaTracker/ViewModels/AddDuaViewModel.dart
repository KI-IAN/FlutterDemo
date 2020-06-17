import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Dua.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Zikir.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/ZikirRepository.dart';
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

  Future<void> addDuaInDB() async {
    DuaRepository duaRepo = DuaRepository();
    ZikirRepository zikirRepo = ZikirRepository();

    var duaID = await duaRepo.insert(Dua(name: dua.name));

//once dua is created successfully, it's time to insert zikirs
    for (int index = 0; index < zikirs.length; index++) {
      await zikirRepo.insert(Zikir(
          name: zikirs.elementAt(index).zikirName,
          duaID: duaID,
          timesToBeRead: zikirs.elementAt(index).numberOfTimesWantToRead,
          timesRead: zikirs.elementAt(index).numberOfTimesRead));
    }
  }

// #endRegion

}
