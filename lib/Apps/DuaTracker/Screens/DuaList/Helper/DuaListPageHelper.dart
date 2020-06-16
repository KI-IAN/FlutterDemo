import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Dua.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaListViewModel.dart';

class DuaListPageHelper {

  
  Future<List<DuaListViewModel>> getDuas() async {
    DuaRepository duaRepo = DuaRepository();

    var duas = await duaRepo.duas();

    List<DuaListViewModel> duaList = List<DuaListViewModel>();

    for (int index = 0; index < duas.length; index++) {
      DuaListViewModel dua = DuaListViewModel();
      dua
      ..duaID = duas.elementAt(index).id
      ..duaName = duas.elementAt(index).name;

        duaList.add(dua);
    }

    return duaList;
  }
}
