import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Helper/EditDuaPageHelper.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaViewModel.dart';

class EditDuaPageFutureVMProvider {
  int duaId;

  EditDuaPageFutureVMProvider(this.duaId);

  Future<EditDuaPageViewModel> getDuaDetails() async {
    EditDuaPageViewModel duaPage = EditDuaPageViewModel(this.duaId);

    //get data from DB
    duaPage.editDuaPageHelper = EditDuaPageHelper();

    var duaDetails = await duaPage.editDuaPageHelper.getDuaDetails(this.duaId);

    EditDuaViewModel duaData = EditDuaViewModel();
    duaData
      ..duaID = duaDetails.elementAt(0).duaID
      ..name = duaDetails.elementAt(0).duaName;

    duaPage.dua = duaData;

    //Set Zikir UI & DB list
    bool hasNoZikir =
        (duaDetails.length == 1 && duaDetails.elementAt(0).zikirID == null);

    //When a dua has at least one or more zikirs, zikir list should be set here
    if (hasNoZikir == false) {
      duaPage.zikirDBList = duaDetails;
      duaPage.zikirUIList = duaDetails.toList();
      duaPage.totalZikirsInUIList = duaPage.zikirUIList.length;
      duaPage.totalZikirsInDBList = duaPage.zikirDBList.length;
    }

    return duaPage;
  }
}
