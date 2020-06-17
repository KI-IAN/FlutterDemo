import 'dart:math';

import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Helper/DuaListPageHelper.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaListPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaListViewModel.dart';

class DuaPageViewModel extends BaseViewModel {
//region : Dua List Fields & Properties

  List<DuaListViewModel> _duaList;

  set duaList(List<DuaListViewModel> value) {
    _duaList = value;
    this.InvokeChanges();
  }

  List<DuaListViewModel> get duaList => _duaList;

//endRegion

//region : Constructor

  DuaPageViewModel() {
    // duaList = getDuaList() as List<DuaListViewModel>;
  }

//endRegion

// Testing :

  Future<DuaPageViewModel> getDuaPageData() async {
    DuaPageViewModel duaPage = DuaPageViewModel();
    duaPage.duaList = await getDuaList();
    return duaPage;
  }

//

//region : Event Handlers
  Future<void> refreshDuaList() async {
    DuaPageViewModel duaPage = DuaPageViewModel();
    duaPage.duaList = await getDuaList();
   
  }

  Future<void> removeDua(int duaID) async {
    duaList.removeWhere((r) => r.duaID == duaID);
    // this.InvokeChanges();
  }

//endRegion

// #region : Data Access

  Future<List<DuaListViewModel>> getDuaList() async {
    DuaListPageHelper duaHelper = DuaListPageHelper();

    var data = await duaHelper.getDuaList();

    return data;
  }

// #endRegion

//region : DataProvider (Temporary)

  // List<DuaListViewModel> getDuaList() {
  //   List<DuaListViewModel> duas = List<DuaListViewModel>();

  //   int totalData = Random().nextInt(50);

  //   for (int index = 0; index < totalData; index++) {
  //     var tempDua = DuaListViewModel();

  //     var minimumZikir = 1;
  //     var minimumZikirRead = 1;

  //     var totalZikir = minimumZikir + Random().nextInt(10);
  //     var totalZikirsRead = Random().nextInt(totalZikir + 1);
  //     var totalNumberOfTimesZikirToBeRead =
  //         minimumZikirRead + Random().nextInt(1000);
  //     var totalNumberOfTimesZikirRead =
  //         Random().nextInt(totalNumberOfTimesZikirToBeRead + 1);

  //     tempDua
  //       ..duaID = index + 1
  //       ..duaName = 'দোয়া # ${index + 1}'
  //       ..totalZikirs = totalZikir
  //       ..totalZikirsRead = totalZikirsRead
  //       ..totalNumberOfTimesZikirToBeRead = totalNumberOfTimesZikirToBeRead
  //       ..totalNumberOfTimesZikirRead = totalNumberOfTimesZikirRead;

  //     duas.add(tempDua);
  //   }

  //   return duas;
  // }

//endRegion

}
