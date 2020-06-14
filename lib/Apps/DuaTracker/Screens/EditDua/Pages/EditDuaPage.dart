import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Pages/EditDuaState.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Styles/EditDuaPageStyles.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/UITexts/EditDuaPageTexts.dart';
import 'package:provider/provider.dart';

//region : Validation Logic (Should find a better maintainable way)
final editDuaFormState = GlobalKey<FormState>();

final addZikirFormState = GlobalKey<FormState>();
//endRegion

class EditDuaPage extends StatelessWidget {
  // #region : Fields
  BuildContext _currentBuildContext;

  int _duaID;

  // #endretion

  // #region : Properties
  set currentBuildContext(BuildContext value) => this._currentBuildContext;

  BuildContext get currentBuildContext => this._currentBuildContext;

  set duaID(int value) => this._duaID = value;

  int get duaID => this._duaID;
  // #endRegion

// #region : Constructor

  EditDuaPage(@required int duaID) {
    this.duaID = duaID;
  }

// #endRegion

  Widget _buildAppBar() => AppBar(
        title: Text(EditDuaPageTexts.editDuaPageTitleBar),
        backgroundColor: EditDuaPageStyles.randomColor(),
      );

  Widget _buildFAB() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(0),
          child: FloatingActionButton(
            onPressed: null,
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
    return ChangeNotifierProvider<EditDuaPageViewModel>(
      create: (BuildContext context) => EditDuaPageViewModel(this.duaID),
      child: EditDuaState(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.currentBuildContext = context;
    return _buildScaffold();
  }
}
