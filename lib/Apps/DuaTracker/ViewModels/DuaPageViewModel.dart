import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Helper/DuaListPageHelper.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaListViewModel.dart';

class DuaPageViewModel extends BaseViewModel {
//region : Dua List Fields & Properties

  List<DuaListViewModel> _duaList;

  set duaList(List<DuaListViewModel> value) {
    _duaList = value;
    this.invokeChanges();
  }

  List<DuaListViewModel> get duaList => _duaList;

//endRegion


//region : Event Handlers

  Future<DuaPageViewModel> refreshDuaList() async {
    DuaPageViewModel duaPage = DuaPageViewModel();
    duaPage.duaList = await getDuaList();
    return duaPage;
  }

  Future<void> removeDua(int duaId) async {
    //remove Dua & Zikirs from DB first
    DuaListPageHelper duaHelper = DuaListPageHelper();

    await duaHelper.removeDuaFromDB(duaId);

    //only then remove from list
    duaList.removeWhere((r) => r.duaID == duaId);
  }

//endRegion

// #region : Data Access

  Future<List<DuaListViewModel>> getDuaList() async {
    DuaListPageHelper duaHelper = DuaListPageHelper();

    var data = await duaHelper.getDuaList();

    return data;
  }

// #endRegion



}
