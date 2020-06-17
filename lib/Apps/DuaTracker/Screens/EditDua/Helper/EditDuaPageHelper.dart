import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Dua.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaTrackerDBContext.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Zikir.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/ZikirRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Enums/CRUDFlagEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditZikirViewModel.dart';
import 'package:sqflite/sqflite.dart';

class EditDuaPageHelper {
  Database _database;
  DuaRepository _duaRepository;
  ZikirRepository _zikirRepository;

  EditDuaPageHelper();

  Future<List<EditZikirViewModel>> getDuaDetails(int duaId) async {
    _database = await DuaTrackerDBContext().initializeDatabase();

    var sqlQuery = '''
Select 
dua.id as duaId,
dua.name as duaName, 
zikir.id as zikirId,
zikir.name as zikirName,
zikir.timesRead as timesRead,
zikir.timesToBeRead as timesToBeRead
from dua
left join zikir on zikir.duaID = dua.id
where dua.id = $duaId;
''';

    List<Map<String, dynamic>> duaDetails = await _database.rawQuery(sqlQuery);

    return List.generate(duaDetails.length, (index) {
      EditZikirViewModel zikir = EditZikirViewModel();
      return zikir
        ..duaID = duaDetails.elementAt(index)['duaId']
        ..duaName = duaDetails.elementAt(index)['duaName']
        ..zikirID = duaDetails.elementAt(index)['zikirId']
        ..zikirName = duaDetails.elementAt(index)['zikirName']
        ..numberOfTimesRead = duaDetails.elementAt(index)['timesRead']
        ..numberOfTimesWantToRead =
            duaDetails.elementAt(index)['timesToBeRead'];
    });
  }

  Future<void> updateDuaList(
      EditDuaViewModel dua, List<EditZikirViewModel> zikirs) async {
    _duaRepository = DuaRepository();
    _zikirRepository = ZikirRepository();

    if (_database == null) {
      _database = await DuaTrackerDBContext().initializeDatabase();
    }

    //update Dua : Update dua regardless of anything
    var duaUpdate =
        await _duaRepository.update(Dua(name: dua.name, id: dua.duaID));

    int zikirCRUDStatus;
    //update Zikirs (Update, Delete, Insert)
    for (int index = 0; index < zikirs.length; index++) {
      var currentZikir = zikirs.elementAt(index);

      Zikir zikir = Zikir(
          id: currentZikir.zikirID,
          name: currentZikir.zikirName,
          timesRead: currentZikir.numberOfTimesRead,
          timesToBeRead: currentZikir.numberOfTimesWantToRead,
          duaID: dua.duaID);

      if (currentZikir.crudFlag == CRUDFlagEnum.Modified) {
        zikirCRUDStatus = await _zikirRepository.update(zikir);
      } else if (currentZikir.crudFlag == CRUDFlagEnum.Deleted) {
        zikirCRUDStatus = await _zikirRepository.delete(currentZikir.zikirID);
      } else if (currentZikir.crudFlag == CRUDFlagEnum.New) {
        zikirCRUDStatus = await _zikirRepository.insert(zikir);
      }
    }
  }
}
