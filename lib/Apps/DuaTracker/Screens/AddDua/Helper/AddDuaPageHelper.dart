import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/Dua.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Repository/DAL/DuaRepository.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaViewModel.dart';

class AddDuaPageHelper {
 
  Future<int> addDua(DuaViewModel dua) {
    DuaRepository duaRepo = DuaRepository();
    return duaRepo.insert(Dua(name: dua.name));
  }


  
}
