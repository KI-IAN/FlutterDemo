import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/SlideDirectionEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Screens/DuaListPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Pages/EditDuaState.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Styles/EditDuaPageStyles.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageFutureVMProvider.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/UITexts/EditDuaPageTexts.dart';
import 'package:provider/provider.dart';

//region : Validation Logic (Should find a better maintainable way)
final editDuaFormState = GlobalKey<FormState>();

final zikirFormState = GlobalKey<FormState>();
//endRegion

class EditDuaPage extends StatelessWidget {
  // #region : Fields
  BuildContext _currentWidgetBuildContext;

  BuildContext _changeNotifierProviderBuildContext;

  int _duaID;

  // #endretion

  // #region : Properties
  set currentWidgetBuildContext(BuildContext value) =>
      this._currentWidgetBuildContext = value;

  BuildContext get currentWidgetBuildContext => this._currentWidgetBuildContext;

  set changeNotifierProviderBuildContext(BuildContext value) =>
      this._changeNotifierProviderBuildContext = value;

  BuildContext get changeNotifierProviderBuildContext =>
      this._changeNotifierProviderBuildContext;

  set duaID(int value) => this._duaID = value;

  int get duaID => this._duaID;
  // #endRegion

// #region : Constructor

  EditDuaPage(@required int duaID) {
    this.duaID = duaID;
  }

// #endRegion

  Widget _buildAppBar() => AppBar(
        title: Text(EditDuaPageTexts().editDuaPageTitleBar),
        backgroundColor: EditDuaPageStyles().randomColor(),
      );

  Widget _buildFAB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0),
          child: FloatingActionButton(
            onPressed: () {
              var isEditFormValid = editDuaFormState.currentState.validate();

              if (isEditFormValid) {

                Navigator.of(this.currentWidgetBuildContext).pushAndRemoveUntil(
                    PageTransition()
                        .createRoute(DuaListPage(), SlideDirectionEnum.Left),
                    (route) => false);
              }
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightBlue,
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    //Solution to async operation / FutureProvider is FutureBuilder!!!
    //Check : https://www.youtube.com/watch?v=ek8ZPdWj4Qo
    return FutureBuilder(
      future: EditDuaPageFutureVMProvider(this.duaID).getDuaDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<EditDuaPageViewModel>(
              create: (context) => snapshot.data, child: EditDuaState());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),

      body: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.currentWidgetBuildContext = context;
    return _buildScaffold();
  }
}
