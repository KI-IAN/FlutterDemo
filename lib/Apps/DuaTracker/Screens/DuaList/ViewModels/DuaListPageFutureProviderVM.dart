import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Helper/DuaListPageHelper.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaPageViewModel.dart';

class DuaListPageFutureProviderVM {
  Future<DuaPageViewModel> getDuaListPageData() async {

    DuaListPageHelper duaHelper = DuaListPageHelper();
    DuaPageViewModel duaPage = DuaPageViewModel();

    duaPage.duaList = await duaHelper.getDuaList();
    return duaPage;
  }
}
