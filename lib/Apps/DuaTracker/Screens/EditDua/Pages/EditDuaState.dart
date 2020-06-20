import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/GeneralAnimationSettings.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/SlideDirectionEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Screens/DuaListPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Enums/FormCRUDModeEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Styles/EditDuaPageStyles.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Validations/EditDuaPageValidator.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditZikirViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Styles/GeneralStyles.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';
import 'package:provider/provider.dart';
import 'editDuaPage.dart';

class EditDuaState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditDua();
}

class EditDua extends State<EditDuaState> {
// #regin : Fields

  BuildContext _currentBuildContext;

  FormCRUDModeEnum _currentFormMode = FormCRUDModeEnum.Read;

// #endRegion

// #region : Global Keys

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

// #endRegion

// #region : Properties

  set currentBuildContext(BuildContext context) => this._currentBuildContext;

  BuildContext get currentBuildContext => this._currentBuildContext;

  set currentFormMode(value) => this._currentFormMode = value;

  FormCRUDModeEnum get currentFormMode => this._currentFormMode;

// #endRegion

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
                          EditDuaPageValidator().duaNameValidator(value),
                      controller: TextEditingController(
                          text: Provider.of<EditDuaPageViewModel>(context,
                                  listen: false)
                              .dua
                              .name),
                      onChanged: (value) {
                        Provider.of<EditDuaPageViewModel>(this.context,
                                listen: false)
                            .dua
                            .name = value;
                      },
                      style: EditDuaPageStyles().dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: EditDuaPageStyles().textFieldBorderStyle(),
                        labelText: getLanguageText('editDuaPage_DuaNameLabel'),
                        hintText:
                            getLanguageText('editDuaPage_DuaNameHintText'),
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
                      style: EditDuaPageStyles().captionLabelTextStyle(),
                    ),
                  ),
                  Consumer<EditDuaPageViewModel>(
                    builder: (context, model, child) {
                      return Expanded(
                          child: Text(
                        '${model?.totalZikirsInUIList} / ${model?.totalZikirsInDBList}',
                        style: EditDuaPageStyles().dataLabelTextStyle(),
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
                child: Consumer<EditDuaPageViewModel>(
                  builder: (context, model, child) {
                    return Text(
                      model.zikirCreateDescription,
                      style: EditDuaPageStyles().secondaryCaptionTextStyle(),
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
                  onPressed: () async {
                    await GeneralAnimationSettings.buttonTapDelay();
                    showZikirForm();
                  }),
            )
          ],
        ),
      );

  void showZikirForm() {
    Provider.of<EditDuaPageViewModel>(context, listen: false)
        .temporaryZikirData = EditZikirViewModel();

    //Update Current Form Mode
    currentFormMode = FormCRUDModeEnum.Create;

    _showAddZikirForm(
        context,
        Provider.of<EditDuaPageViewModel>(context, listen: false)
            .temporaryZikirData);
  }

  void editInDB() async {
    var isEditFormValid = editDuaFormState.currentState.validate();

    if (isEditFormValid) {
      //update in Database
      await Provider.of<EditDuaPageViewModel>(context, listen: false)
          .updateDatabase();

      Navigator.of(this.context).pushAndRemoveUntil(
          PageTransition().createRoute(DuaListPage(), SlideDirectionEnum.Left),
          (route) => false);
    }
  }

  Future<void> _showAddZikirForm(
      BuildContext parentContext, EditZikirViewModel zikirdata) async {
    return showGeneralDialog<void>(
        //Default Build Context is different for GeneralDialog than its caller.
        //In ordeer to be able to access same Provider data, we have to replace
        //the original context of GeneralDialog with the caller's Build Context
        //To know more : https://stackoverflow.com/questions/58815932/flutter-showgeneraldialog-does-not-share-a-context-with-the-location-that-showg
        // context: parentContext,
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
                    key: zikirFormState,
                    autovalidate: true,
                    child: _buildZikirItem(parentContext, zikirdata),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildZikirItem(BuildContext context, EditZikirViewModel data) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                enabled: true,
                validator: (value) =>
                    EditDuaPageValidator().zikirNameValidator(value),
                controller: TextEditingController(
                  text: data.zikirName,
                ),
                onChanged: (String value) {
                  Provider.of<EditDuaPageViewModel>(context, listen: false)
                      .temporaryZikirData
                      .zikirName = value;
                },
                style: EditDuaPageStyles().dataLabelTextStyle(),
                decoration: InputDecoration(
                  border: EditDuaPageStyles().textFieldBorderStyle(),
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
                          enabled: true,
                          validator: (value) => EditDuaPageValidator()
                              .numberOfTimesWantToReadValidator(value),
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead?.toString(),
                          ),
                          onChanged: (value) {
                            Provider.of<EditDuaPageViewModel>(context,
                                    listen: false)
                                .temporaryZikirData
                                .numberOfTimesWantToRead = int.parse(value);
                          },
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: EditDuaPageStyles().dataLabelTextStyle(),
                          decoration: InputDecoration(
                            labelText: getLanguageText(
                                'editDuaPage_NumberOfTimesWantToReadLabel'),
                            border: EditDuaPageStyles().textFieldBorderStyle(),
                            hintText: getLanguageText(
                                'editDuaPage_NumberOfTimesWantToReadHintText'),
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          getLanguageText('editDuaPage_TimesLabel'),
                          style: EditDuaPageStyles().captionLabelTextStyle(),
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
                            Provider.of<EditDuaPageViewModel>(context,
                                        listen: false)
                                    .temporaryZikirData
                                    .numberOfTimesWantToRead ??
                                0;

                        return EditDuaPageValidator()
                            .numberOfTimesReadValidator(
                                value, zikirMaxTimeToBeRead);
                      },
                      controller: TextEditingController(
                        text: data.numberOfTimesRead?.toString(),
                      ),
                      onChanged: (value) {
                        Provider.of<EditDuaPageViewModel>(context,
                                listen: false)
                            .temporaryZikirData
                            .numberOfTimesRead = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: EditDuaPageStyles().dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: EditDuaPageStyles().textFieldBorderStyle(),
                        labelText: getLanguageText(
                            'editDuaPage_NumberOfTimesReadLabel'),
                        hintText: getLanguageText(
                            'editDuaPage_NumberOfTimesReadHintText'),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      getLanguageText('editDuaPage_TimesLabel'),
                      style: EditDuaPageStyles().captionLabelTextStyle(),
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
                  Visibility(
                    child: _buildZikirFormEditButton(),
                    visible: (currentFormMode == FormCRUDModeEnum.Update),
                    maintainSize: false,
                    replacement: _buildZikirFormSaveButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildZikirFormSaveButton() => Center(
          child: Ink(
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Colors.lightGreen),
        child: IconButton(
          splashColor: GeneralStyles.buttonSplashColor(),
          icon: Icon(Icons.save),
          alignment: Alignment.center,
          tooltip: getLanguageText('editDuaPage_ZikirSaveButtonToolTip'),
          color: Colors.white,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();
            createNewZikir();
          },
        ),
      ));

  void createNewZikir() {
    var isFormValid = zikirFormState.currentState.validate();

    if (isFormValid) {
      Provider.of<EditDuaPageViewModel>(this.context, listen: false)
          .addNewZikir();

      Navigator.pop(context);

      animatedListKey.currentState.insertItem(
          Provider.of<EditDuaPageViewModel>(this.context, listen: false)
                  .zikirUIList
                  .length -
              1);
    }
  }

  Widget _buildZikirFormEditButton() => Center(
          child: Ink(
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Colors.lightBlue),
        child: IconButton(
          splashColor: GeneralStyles.buttonSplashColor(),
          icon: Icon(Icons.edit),
          alignment: Alignment.center,
          tooltip: getLanguageText('editDuaPage_ZikirSaveButtonToolTip'),
          color: Colors.white,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();
            editZikir();
          },
        ),
      ));

  void editZikir() {
    var isFormValid = zikirFormState.currentState.validate();

    if (isFormValid) {
      Provider.of<EditDuaPageViewModel>(this.context, listen: false)
          .updateZikir();

      Navigator.pop(context);
    }
  }

  Widget _buildDeleteButton(int currentIndex) => Center(
          child: Ink(
        decoration:
            const ShapeDecoration(shape: CircleBorder(), color: Colors.red),
        child: IconButton(
          splashColor: GeneralStyles.buttonSplashColor(),
          icon: Icon(Icons.delete_forever),
          alignment: Alignment.center,
          tooltip: getLanguageText('editDuaPage_ZikirDeleteButtonToolTip'),
          color: Colors.white,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();

            var selectedItem =
                Provider.of<EditDuaPageViewModel>(context, listen: false)
                    .zikirUIList
                    .elementAt(currentIndex);

            Provider.of<EditDuaPageViewModel>(this.context, listen: false)
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

  Widget _buildEditButton(int currentIndex, EditZikirViewModel data) => Center(
          child: Ink(
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Colors.lightBlue),
        child: IconButton(
          splashColor: GeneralStyles.buttonSplashColor(),
          icon: Icon(Icons.edit),
          alignment: Alignment.center,
          tooltip: getLanguageText('editDuaPage_ZikirEditButtonToolTip'),
          color: Colors.white,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();
            //Creating a new zikir model to break refereence issue that occurs when updating a zikir is incomplete.
            EditZikirViewModel currentData =
                Provider.of<EditDuaPageViewModel>(context, listen: false)
                    .getACopyOf(data);

            Provider.of<EditDuaPageViewModel>(context, listen: false)
                .temporaryZikirData = currentData;

            //Update current Form Mode
            currentFormMode = FormCRUDModeEnum.Update;

            _showAddZikirForm(
                context,
                Provider.of<EditDuaPageViewModel>(context, listen: false)
                    .temporaryZikirData);
          },
        ),
      ));

  Widget _buildDuaItem(
      BuildContext context, int currentIndex, EditZikirViewModel data) {
    return Container(
      child: Card(
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
                style: EditDuaPageStyles().dataLabelTextStyle(),
                decoration: InputDecoration(
                    border: EditDuaPageStyles().textFieldBorderStyle(),
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
                          enabled: false,
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead?.toString(),
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: EditDuaPageStyles().dataLabelTextStyle(),
                          decoration: InputDecoration(
                            border: EditDuaPageStyles().textFieldBorderStyle(),
                            labelText: getLanguageText(
                                'editDuaPage_NumberOfTimesWantToReadLabel'),
                            hintText: getLanguageText(
                                'editDuaPage_NumberOfTimesWantToReadHintText'),
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          getLanguageText('editDuaPage_TimesLabel'),
                          style: EditDuaPageStyles().captionLabelTextStyle(),
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
                      style: EditDuaPageStyles().dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: EditDuaPageStyles().textFieldBorderStyle(),
                        labelText: getLanguageText(
                            'editDuaPage_NumberOfTimesReadLabel'),
                        hintText: getLanguageText(
                            'editDuaPage_NumberOfTimesReadHintText'),
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      getLanguageText('editDuaPage_TimesLabel'),
                      style: EditDuaPageStyles().captionLabelTextStyle(),
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
                  _buildEditButton(currentIndex, data),
                  Text(data.crudFlagName),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFullPage() => Container(
        child: Form(
          key: editDuaFormState,
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

  Widget _buildFABEdit() {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
          splashColor: GeneralStyles.buttonSplashColor(),
          backgroundColor: Colors.lightBlue,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();
            editInDB();
          },
          child: Icon(
            Icons.edit,
            color: Colors.white,
          )),
    );
  }

  Widget _buildAnimatedDuaList() {
    var animatedListView = Consumer<EditDuaPageViewModel>(
      builder:
          (BuildContext context, EditDuaPageViewModel model, Widget child) {
        return AnimatedList(
          key: animatedListKey,
          initialItemCount: model.zikirUIList.length,
          itemBuilder: (BuildContext context, int currentIndex,
              Animation<double> animation) {
            var selectedData = model.zikirUIList.elementAt(currentIndex);
            return SizeTransition(
                sizeFactor: animation,
                child: _buildDuaItem(context, currentIndex, selectedData));
          },
        );
      },
    );

    return animatedListView;
  }

  @override
  Widget build(BuildContext context) {
    currentBuildContext = context;
    return Stack(
      children: <Widget>[
        _buildFullPage(),
        _buildFABEdit(),
      ],
    );
  }
}
