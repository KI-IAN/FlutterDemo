import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaTrackerDBContext.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditZikirViewModel.dart';
import 'package:sqflite/sqflite.dart';

class EditDuaPageHelper {
  Database _database;

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
}
