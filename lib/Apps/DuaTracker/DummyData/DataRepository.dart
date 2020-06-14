import 'dart:math';

import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditZikirViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaListViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaViewModel.dart';

class DummyDataRepository {
  List<EditDuaViewModel> _duas;
  List<EditZikirViewModel> _zikirs;

  DummyDataRepository() {
    // int maxDuas = 1 + Random().nextInt(10);
    // int maxZikirs = Random().nextInt(5);

    int maxDuas = 10;
    int maxZikirs = 5;

    _duas = getAllDuas(maxDuas);
    _zikirs = getAllZikirs(maxDuas, maxZikirs);
  }

  // EditDuaPageViewModel editDua(int duaID) {
  //   EditDuaPageViewModel duaData = EditDuaPageViewModel();

  //   duaData.dua.name =
  //       _duas.firstWhere((element) => element.duaID == duaID).name;

  //   var zikirList = _zikirs.where((element) => element.duaID == duaID);

  //   duaData.zikirUIList = duaData.zikirDBList = zikirList;

  //   return duaData;
  // }

  EditDuaViewModel getDua(int duaID) {
    return _duas.firstWhere((element) => element.duaID == duaID);
  }

  List<EditZikirViewModel> getZikirs(int duaID) {
    return _zikirs.where((element) => element.duaID == duaID).toList();
  }

  // List<DuaListViewModel> getDuaList() {
  //   List<DuaListViewModel> duas = List<DuaListViewModel>();

  //   for (int duaID = 0; duaID < _duas.length; duaID++) {
  //     duas.elementAt(duaID)
  //       ..duaName = _duas.elementAt(duaID).name
  //       ..totalZikirs =
  //           _zikirs.where((element) => element.duaID == duaID).length
  //       ..totalNumberOfTimesZikirToBeRead = _zikirs
  //           .where((element) => element.duaID == duaID).iterator ;
  //   }
  // }

  List<EditZikirViewModel> getAllZikirs(int totalDuas, int maxNumOfZikirs) {
    List<EditZikirViewModel> zikirs = List<EditZikirViewModel>();

    for (int duaID = 1; duaID <= totalDuas; duaID++) {
      int totalZikir = Random().nextInt(maxNumOfZikirs);

      // int totalZikir = maxNumOfZikirs;

      for (int zikirID = 1; zikirID <= totalZikir; zikirID++) {
        EditZikirViewModel zikir = EditZikirViewModel();

        int numOfTimesWantToRead = Random().nextInt(999);
        int numOfTimesRead = Random().nextInt(numOfTimesWantToRead);

        zikir
          ..duaID = duaID
          ..zikirID = zikirID
          ..zikirName = 'জিকির # $zikirID'
          ..numberOfTimesRead = numOfTimesRead
          ..numberOfTimesWantToRead = numOfTimesWantToRead;

        zikirs.add(zikir);
      }
    }

    return zikirs;
  }

  List<EditDuaViewModel> getAllDuas(int totalDuas) {
    List<EditDuaViewModel> duas = List<EditDuaViewModel>();

    for (int duaID = 1; duaID <= totalDuas; duaID++) {
      var dua = EditDuaViewModel();

      dua
        ..name = 'দোয়া # $duaID'
        ..duaID = duaID;

      duas.add(dua);
    }

    return duas;
  }
}
