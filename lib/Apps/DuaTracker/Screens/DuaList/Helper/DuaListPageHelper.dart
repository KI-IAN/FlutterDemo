import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Dua.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaTrackerDBContext.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/ZikirRepository.dart';
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

  Future<void> removeDuaFromDB(int duaId) async {
    DuaRepository duaRepo = DuaRepository();

    ZikirRepository zikirRepo = ZikirRepository();

    //get all zikirIDs
    List<int> zikirIDs = await getZikirIds(duaId);

    //remove all zikirs first
    for(int index = 0; index < zikirIDs.length; index++ ){

      await zikirRepo.delete(zikirIDs.elementAt(index));
    }

    //remove dua
    await duaRepo.delete(duaId);

  }

  Future<List<int>> getZikirIds(int duaId) async {
    var db = await DuaTrackerDBContext().initializeDatabase();

    var query = '''Select zikir.id as zikirId from dua
inner join zikir on zikir.duaID = dua.id
where dua.id = $duaId''';

    List<Map<String, dynamic>> zikirIds = await db.rawQuery(query);

    return List.generate(zikirIds.length, (index) {
      return zikirIds.elementAt(index)['zikirId'];
    });
  }

  Future<List<DuaListViewModel>> getDuaList() async {
    var db = await DuaTrackerDBContext().initializeDatabase();

    var query = '''Select dua.name as duaName, dua.id as duaID,
CAST('0' as INTEGER) as totalZikirRead,
ifnull(Sum(zikir.timesRead),0) as timesRead, ifnull(Sum(zikir.timesToBeRead),0) as timesToBeRead,
ifnull(count(zikir.id),0) as totalZikir from dua
left join zikir on dua.id = zikir.duaID
GROUP by dua.id''';

    List<Map<String, dynamic>> data = await db.rawQuery(query);

    return List.generate(data.length, (index) {
      DuaListViewModel dua = DuaListViewModel();

      return dua
        ..duaName = data.elementAt(index)['duaName']
        ..duaID = data.elementAt(index)['duaID']
        ..totalNumberOfTimesZikirRead = data.elementAt(index)['timesRead']
        ..totalNumberOfTimesZikirToBeRead =
            data.elementAt(index)['timesToBeRead']
        ..totalZikirs = data.elementAt(index)['totalZikir']
        ..totalZikirsRead = data.elementAt(index)['totalZikirRead'];
    });
  }
}
