import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/SlideDirectionEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/AddDua/Styles/AddDuaPageStyles.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/AddDua/Validations/AddDuaPageValidators.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Screens/DuaListPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/AddDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/ZikirViewModel.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';
import 'package:provider/provider.dart';

//region : Validation Logic (Should find a better maintainable way)
final addDuaFormState = GlobalKey<FormState>();

final addZikirFormState = GlobalKey<FormState>();

//endRegion

class AddDuaPage extends StatelessWidget {
  BuildContext _currentContext;

  Widget _buildAppBar() => AppBar(
        title: Text(getLanguageText('addDuaPage_TitleBarText')),
        backgroundColor: randomColor(),
      );

  Widget _buildScaffold(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: ChangeNotifierProvider<AddDuaViewModel>(
          create: (context) => AddDuaViewModel(),
          child: AddDuaState(),
        ),
        // body: AddDuaState(),
      );

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

/* #region : Event Handlers */

  void goBackToDuaListPage() {
    Navigator.pop(_currentContext);
  }

  void saveDua() {
    //validate dua & Zikir list
    var isFormValid = addDuaFormState.currentState.validate();

    if (isFormValid) {
      //save dua & zikirs in db

      //To know how it pushAndRemoveUntil works : https://stackoverflow.com/questions/45889341/flutter-remove-all-routes
      Navigator.of(_currentContext).pushAndRemoveUntil(
          PageTransition().createRoute(DuaListPage(), SlideDirectionEnum.Left),
          (route) => false);
    }
  }

/* #endregion */

}

class AddDuaState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddDua();
}

class AddDua extends State<AddDuaState> {
  BuildContext _currentContext;

  int _listViewSelectedItemIndex;

  Widget _buildDuaContainer() => Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          AddDuaPageValidator().duaNameValidator(value),
                      controller: TextEditingController(
                          text: Provider.of<AddDuaViewModel>(context,
                                  listen: false)
                              .dua
                              .name),
                      onChanged: (value) {
                        Provider.of<AddDuaViewModel>(this.context,
                                listen: false)
                            .dua
                            .name = value;
                      },
                      style: AddDuaPageStyles().dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: AddDuaPageStyles().textFieldBorderStyle(),
                        labelText: getLanguageText('editDuaPage_DuaNameLabel'),
                        hintText: getLanguageText('editDuaPage_DuaNameHintText'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      getLanguageText('editDuaPage_TotalZikirLabel'),
                      style: AddDuaPageStyles().captionLabelTextStyle(),
                    ),
                  ),
                  Consumer<AddDuaViewModel>(
                    builder: (context, model, child) {
                      return Expanded(
                          child: Text(
                        '${model.totalZikirs}',
                        style: AddDuaPageStyles().dataLabelTextStyle(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildAddZikirContainer() => Card(
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Consumer<AddDuaViewModel>(
                  builder: (context, model, widget) {
                    return Text(
                      model.zikirCreateDescription,
                      style: AddDuaPageStyles().secondaryCaptionTextStyle(),
                    );
                  },
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.all(5),
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.lightGreen,
                    size: 35,
                  ),
                  onPressed: () {
                    Provider.of<AddDuaViewModel>(context, listen: false)
                        .temporaryZikirData = ZikirViewModel();

                    _showAddZikirForm(
                        context,
                        Provider.of<AddDuaViewModel>(context, listen: false)
                            .temporaryZikirData);
                  }),
            )
          ],
        ),
      );

  void saveInDB() async {
    var isFormValid = addDuaFormState.currentState.validate();

    if (isFormValid) {
      await Provider.of<AddDuaViewModel>(context, listen: false).addDuaInDB();

      //To know how it pushAndRemoveUntil works : https://stackoverflow.com/questions/45889341/flutter-remove-all-routes
      Navigator.of(_currentContext).pushAndRemoveUntil(
          PageTransition().createRoute(DuaListPage(), SlideDirectionEnum.Left),
          (route) => false);
    }
  }

  Future<void> _showAddZikirForm(
      BuildContext parentContext, ZikirViewModel zikirdata) async {
    return showGeneralDialog<void>(
        //Default Build Context is different for GeneralDialog than its caller.
        //In ordeer to be able to access same Provider data, we have to replace
        //the original context of GeneralDialog with the caller's Build Context
        //To know more : https://stackoverflow.com/questions/58815932/flutter-showgeneraldialog-does-not-share-a-context-with-the-location-that-showg
        context: parentContext,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        transitionDuration: Duration(milliseconds: 1 * 500),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Align(
            alignment: Alignment.center,
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                  child: Form(
                    key: addZikirFormState,
                    autovalidate: true,
                    child: _buildZikirItem(parentContext, zikirdata),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildDuaItem(
      BuildContext context, int currentIndex, ZikirViewModel data) {
    return Container(
      child: Card(
        // color: (currentIndex % 2 == 0) ? Colors.white : Colors.yellow[50],
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                enabled: false,
                controller: TextEditingController(
                  text: data.zikirName,
                ),
                style: AddDuaPageStyles().dataLabelTextStyle(),
                decoration: InputDecoration(
                  border: AddDuaPageStyles().textFieldBorderStyle(),
                  labelText: getLanguageText('editDuaPage_ZikirNameLabel'),
                  hintText: getLanguageText('editDuaPage_ZikirHintText'),
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead?.toString(),
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: AddDuaPageStyles().dataLabelTextStyle(),
                          decoration: InputDecoration(
                            labelText: getLanguageText('editDuaPage_NumberOfTimesWantToReadLabel'),
                            hintText: getLanguageText('editDuaPage_NumberOfTimesWantToReadHintText'),
                            border: AddDuaPageStyles().textFieldBorderStyle(),
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          // 'বার',
                          getLanguageText('editDuaPage_TimesLabel'),
                          style: AddDuaPageStyles().captionLabelTextStyle(),
                        ),
                      ),
                    ]),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      enabled: false,
                      controller: TextEditingController(
                        text: data.numberOfTimesRead?.toString(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: AddDuaPageStyles().dataLabelTextStyle(),
                      decoration: InputDecoration(
                        labelText:
                            getLanguageText('editDuaPage_NumberOfTimesReadLabel'),
                        hintText: getLanguageText('editDuaPage_NumberOfTimesReadHintText'),
                        border: AddDuaPageStyles().textFieldBorderStyle(),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      // 'বার',
                      getLanguageText('editDuaPage_TimesLabel'),
                      style: AddDuaPageStyles().captionLabelTextStyle(),
                    ),
                  ),
                ]),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              thickness: 1.0,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildDeleteButton(currentIndex),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildZikirItem(BuildContext context, ZikirViewModel data) {
    return Container(
      child: Card(
        // color: (currentIndex % 2 == 0) ? Colors.white : Colors.yellow[50],
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                enabled: true,
                validator: (value) =>
                    AddDuaPageValidator().zikirNameValidator(value),
                controller: TextEditingController(
                  text: data.zikirName,
                ),
                onChanged: (String value) {
                  Provider.of<AddDuaViewModel>(context, listen: false)
                      .temporaryZikirData
                      .zikirName = value;
                },
                style: AddDuaPageStyles().dataLabelTextStyle(),
                decoration: InputDecoration(
                    border: AddDuaPageStyles().textFieldBorderStyle(),
                    labelText: getLanguageText('editDuaPage_ZikirNameLabel'),
                    hintText: getLanguageText('editDuaPage_ZikirHintText')),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: TextFormField(
                          enabled: true,
                          validator: (value) => AddDuaPageValidator()
                              .numberOfTimesWantToReadValidator(value),
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead?.toString(),
                          ),
                          onChanged: (value) {
                            Provider.of<AddDuaViewModel>(context, listen: false)
                                .temporaryZikirData
                                .numberOfTimesWantToRead = int.parse(value);
                          },
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: AddDuaPageStyles().dataLabelTextStyle(),
                          decoration: InputDecoration(
                            labelText: getLanguageText('editDuaPage_NumberOfTimesWantToReadLabel'),
                            hintText: getLanguageText('editDuaPage_NumberOfTimesWantToReadHintText'),
                            border: AddDuaPageStyles().textFieldBorderStyle(),
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          // 'বার',
                          getLanguageText('editDuaPage_TimesLabel'),
                          style: AddDuaPageStyles().captionLabelTextStyle(),
                        ),
                      ),
                    ]),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      enabled: true,
                      validator: (value) {
                        var zikirMaxTimeToBeRead =
                            Provider.of<AddDuaViewModel>(context, listen: false)
                                    .temporaryZikirData
                                    .numberOfTimesWantToRead ??
                                0;

                        return AddDuaPageValidator().numberOfTimesReadValidator(
                            value, zikirMaxTimeToBeRead);
                      },
                      controller: TextEditingController(
                        text: data.numberOfTimesRead?.toString(),
                      ),
                      onChanged: (value) {
                        Provider.of<AddDuaViewModel>(context, listen: false)
                            .temporaryZikirData
                            .numberOfTimesRead = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: AddDuaPageStyles().dataLabelTextStyle(),
                      decoration: InputDecoration(
                        labelText:
                            getLanguageText('editDuaPage_NumberOfTimesReadLabel'),
                        hintText: getLanguageText('editDuaPage_NumberOfTimesReadHintText'),
                        border: AddDuaPageStyles().textFieldBorderStyle(),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      // 'বার',
                      getLanguageText('editDuaPage_TimesLabel'),
                      style: AddDuaPageStyles().captionLabelTextStyle(),
                    ),
                  ),
                ]),
              ),
            ),
            Divider(
              color: Colors.lightBlue,
              thickness: 1.0,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildZikirSaveButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildZikirSaveButton() => Center(
          child: Ink(
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Colors.lightGreen),
        child: IconButton(
          icon: Icon(Icons.save),
          alignment: Alignment.center,
          tooltip: getLanguageText('editDuaPage_ZikirSaveButtonToolTip'),
          color: Colors.white,
          onPressed: () {
            var isFormValid = addZikirFormState.currentState.validate();

            if (isFormValid) {
              Provider.of<AddDuaViewModel>(this.context, listen: false)
                  .addNewZikir();

              Navigator.pop(context);

              animatedListKey.currentState.insertItem(
                  Provider.of<AddDuaViewModel>(this.context, listen: false)
                          .zikirs
                          .length -
                      1);
            }
          },
        ),
      ));

  Widget _buildDeleteButton(int currentIndex) => Center(
          child: Ink(
        decoration:
            const ShapeDecoration(shape: CircleBorder(), color: Colors.red),
        child: IconButton(
          icon: Icon(Icons.delete_forever),
          alignment: Alignment.center,
          // tooltip: 'তথ্য মুছুন',
          tooltip: getLanguageText('editDuaPage_ZikirDeleteButtonToolTip'),
          color: Colors.white,
          onPressed: () {
            var selectedItem = getDataAt(
                Provider.of<AddDuaViewModel>(context, listen: false).zikirs,
                currentIndex);

            Provider.of<AddDuaViewModel>(this.context, listen: false)
                .removeZikirFromList(currentIndex);

            animatedListKey.currentState.removeItem(
                currentIndex,
                (context, animation) => SizeTransition(
                      sizeFactor: animation,
                      child: _buildDuaItem(context, currentIndex, selectedItem),
                    ));
          },
        ),
      ));

// #region : AnimatedList

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  Widget _buildAnimatedDuaList() {
    var animatedListView = Consumer<AddDuaViewModel>(
      builder: (BuildContext context, AddDuaViewModel model, Widget child) {
        return AnimatedList(
          key: animatedListKey,
          initialItemCount: model.zikirs.length,
          itemBuilder: (BuildContext context, int currentIndex,
              Animation<double> animation) {
            this._listViewSelectedItemIndex = currentIndex;
            var currentData = getDataAt(model.zikirs, currentIndex);
            return SizeTransition(
                sizeFactor: animation,
                child: _buildDuaItem(context, currentIndex, currentData));
          },
        );
      },
    );

    return animatedListView;
  }

// #endregion

  Widget _buildFullPage() => Container(
        child: Form(
          key: addDuaFormState,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              _buildDuaContainer(),
              _buildAddZikirContainer(),
              Expanded(child: _buildAnimatedDuaList()),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    this._currentContext = context;
    return Stack(
      children: <Widget>[
        _buildFullPage(),
        _buildFABSave(),
      ],
    );
  }

  Widget _buildFABSave() {
    return Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            onPressed: saveInDB,
            child: Icon(
              Icons.save,
              color: Colors.white,
            )),
      );
  }

  ZikirViewModel getDataAt(List<ZikirViewModel> data, int selectedIndex) {
    var selectedData = data.elementAt(selectedIndex);
    return selectedData;
  }
}
