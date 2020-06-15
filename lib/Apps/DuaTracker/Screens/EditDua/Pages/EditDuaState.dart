import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Styles/EditDuaPageStyles.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Validations/EditDuaPageValidator.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditDuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/ViewModels/EditZikirViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/UITexts/EditDuaPageTexts.dart';
import 'package:provider/provider.dart';
import 'EditDuaPage.dart';

class EditDuaState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditDua();
}

class EditDua extends State<EditDuaState> {
// #regin : Fields

  BuildContext _currentBuildContext;

// #endRegion

// #region : Global Keys

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

// #endRegion

// #region : Properties

  set currentBuildContext(BuildContext context) => this._currentBuildContext;

  BuildContext get currentBuildContext => this._currentBuildContext;

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
                          EditDuaPageValidator.duaNameValidator(value),
                      controller: TextEditingController(
                          text: Provider.of<EditDuaPageViewModel>(context,
                                  listen: false)
                              .dua
                              .name),
                      onChanged: (value) {
                        Provider.of<EditDuaPageViewModel>(this.context)
                            .dua
                            .name = value;
                      },
                      style: EditDuaPageStyles.dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: EditDuaPageStyles.textFieldBorderStyle(),
                        labelText: EditDuaPageTexts.editDuaPageDuaNameLabel,
                        // hintText: 'দোয়া কেন পড়ছেন সেই কারণটির নাম লিখুন',
                        hintText: EditDuaPageTexts.editDuaPageDuaNameHintText,
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
                      // 'মোট জিকির',
                      EditDuaPageTexts.editDuaPageTotalZikirLabel,
                      style: EditDuaPageStyles.captionLabelTextStyle(),
                    ),
                  ),
                  Consumer<EditDuaPageViewModel>(
                    builder: (context, model, child) {
                      return Expanded(
                          child: Text(
                        '${model.totalZikirsInUIList} / ${model.totalZikirsInDBList}',
                        style: EditDuaPageStyles.dataLabelTextStyle(),
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
                child: Text(
                  // 'এখনো কোন জিকির নেই। নতুন জিকির তৈরি করি।',
                  EditDuaPageTexts.createNewZikirLabel,
                  style: EditDuaPageStyles.secondaryCaptionTextStyle(),
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
                    Provider.of<EditDuaPageViewModel>(context, listen: false)
                        .temporaryZikirData = EditZikirViewModel();

                    currentBuildContext =
                        this.context; //It does not work!!!!!!!

                    _showAddZikirForm(
                        context,
                        Provider.of<EditDuaPageViewModel>(context,
                                listen: false)
                            .temporaryZikirData);
                  }),
            )
          ],
        ),
      );

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
                    key: addZikirFormState,
                    autovalidate: true,
                    // child: _buildZikirItem(parentContext, zikirdata),
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
        // color: (currentIndex % 2 == 0) ? Colors.white : Colors.yellow[50],
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                enabled: true,
                // validator: MultiValidator([
                //   RequiredValidator(errorText: 'জিকিরের নাম আবশ্যক'),
                //   MinLengthValidator(1,
                //       errorText: 'জিকিরের নাম অন্তত এক অক্ষর বিশিষ্ট হতে হবে'),
                //   MaxLengthValidator(10,
                //       errorText: 'জিকিরের নাম ১০  অক্ষরের বেশি হতে পারবে না'),
                // ]),
                validator: (value) =>
                    EditDuaPageValidator.zikirNameValidator(value),
                controller: TextEditingController(
                  text: data.zikirName,
                ),
                onChanged: (String value) {
                  // model.zikirs[currentIndex].zikirName = value;
                  // Provider.of<AddDuaViewModel>(context, listen: false)
                  //     .zikirs[currentIndex]
                  //     .zikirName = value;
                  // Provider.of<AddDuaViewModel>(context, listen: false)
                  //     .temporaryZikirData
                  //     .zikirName = value;
                  Provider.of<EditDuaPageViewModel>(context, listen: false)
                      .temporaryZikirData
                      .zikirName = value;
                },
                style: EditDuaPageStyles.dataLabelTextStyle(),
                decoration: InputDecoration(
                  border: EditDuaPageStyles.textFieldBorderStyle(),
                  // labelText: 'জিকিরের নাম',
                  labelText: EditDuaPageTexts.editDuaPageZikirNameLabel,
                  // hintText: 'সূরার নাম'
                  hintText: EditDuaPageTexts.editDuaPageZikirHintText,
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
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: 'আবশ্যক'),
                          //   RangeValidator(
                          //       min: 1,
                          //       max: 999,
                          //       errorText: '১ - ৯৯৯ এর মাঝে যে কোন সংখ্যা')
                          // ]),
                          validator: (value) => EditDuaPageValidator
                              .numberOfTimesWantToReadValidator(value),
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead?.toString(),
                          ),
                          onChanged: (value) {
                            // Provider.of<AddDuaViewModel>(context, listen: false)
                            //     .zikirs[currentIndex]
                            //     .numberOfTimesWantToRead = int.parse(value);
                            // Provider.of<AddDuaViewModel>(context, listen: false)
                            //     .temporaryZikirData
                            //     .numberOfTimesWantToRead = int.parse(value);
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
                          style: EditDuaPageStyles.dataLabelTextStyle(),
                          decoration: InputDecoration(
                            // labelText: 'পড়তে চাই',
                            labelText: EditDuaPageTexts
                                .editDuaPageNumberOfTimesWantToReadLabel,
                            border: EditDuaPageStyles.textFieldBorderStyle(),
                            // hintText:
                            //     '১০০ (যতবার পড়তে চান সেই সংখ্যাটি লিখুন)'
                            hintText: EditDuaPageTexts
                                .editDuaPageNumberOfTimesWantToReadHintText,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          // 'বার',
                          EditDuaPageTexts.editDuaPageTimesLabel,
                          style: EditDuaPageStyles.captionLabelTextStyle(),
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
                      // validator: MultiValidator([
                      //   RequiredValidator(errorText: 'আবশ্যক'),
                      // ]),
                      validator: (value) =>
                          EditDuaPageValidator.numberOfTimesReadValidator(
                              value),
                      controller: TextEditingController(
                        text: data.numberOfTimesRead?.toString(),
                      ),
                      onChanged: (value) {
                        // Provider.of<AddDuaViewModel>(context, listen: false)
                        //     .zikirs[currentIndex]
                        //     .numberOfTimesRead = int.parse(value);
                        // Provider.of<AddDuaViewModel>(context, listen: false)
                        //     .temporaryZikirData
                        //     .numberOfTimesRead = int.parse(value);
                        Provider.of<EditDuaPageViewModel>(context,
                                listen: false)
                            .temporaryZikirData
                            .numberOfTimesRead = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: EditDuaPageStyles.dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: EditDuaPageStyles.textFieldBorderStyle(),
                        // labelText: 'পড়েছি',
                        labelText:
                            EditDuaPageTexts.editDuaPageNumberOfTimesReadLabel,
                        // hintText:
                        //     '৫০ (যতবার এখন পর্যন্ত পড়েছেন সেই সংখ্যাটি লিখুন)'
                        hintText: EditDuaPageTexts
                            .editDuaPageNumberOfTimesReadHintText,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      // 'বার',
                      EditDuaPageTexts.editDuaPageTimesLabel,
                      style: EditDuaPageStyles.captionLabelTextStyle(),
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
                  // _buildDeleteButton(currentIndex),
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
          // tooltip: 'তথ্য সংরক্ষণ করুন',
          tooltip: EditDuaPageTexts.editDuaPageZikirSaveButtonToolTip,
          color: Colors.white,
          onPressed: () {
            // print('currentIndex : $currentIndex');

            var isFormValid = addZikirFormState.currentState.validate();

            if (isFormValid) {
              // Provider.of<AddDuaViewModel>(this.context, listen: false)
              //     .addNewZikir();

              //  Provider.of<AddDuaViewModel>(this.context, listen: false)
              //       .addNewZikir();

              Provider.of<EditDuaPageViewModel>(this.context, listen: false)
                  .addNewZikir();

              Navigator.pop(context);

              // animatedListKey.currentState.insertItem(
              //     Provider.of<AddDuaViewModel>(this.context, listen: false)
              //             .zikirs
              //             .length -
              //         1);

              animatedListKey.currentState.insertItem(
                  Provider.of<EditDuaPageViewModel>(this.context, listen: false)
                          .zikirUIList
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
          tooltip: 'তথ্য মুছুন',
          color: Colors.white,
          onPressed: () {
            print('currentIndex : $currentIndex');

            // var selectedItem = getDataAt(
            //     Provider.of<AddDuaViewModel>(context, listen: false).zikirs,
            //     currentIndex);

            var selectedItem =
                Provider.of<EditDuaPageViewModel>(context, listen: false)
                    .zikirUIList
                    .elementAt(currentIndex);

            // Provider.of<AddDuaViewModel>(this.context, listen: false)
            //     .removeZikirFromList(currentIndex);

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

  Widget _buildDuaItem(
      BuildContext context, int currentIndex, EditZikirViewModel data) {
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
                style: EditDuaPageStyles.dataLabelTextStyle(),
                decoration: InputDecoration(
                    border: EditDuaPageStyles.textFieldBorderStyle(),
                    // labelText: 'জিকিরের নাম',
                    // hintText: 'সূরার নাম'
                    labelText: EditDuaPageTexts.editDuaPageZikirNameLabel,
                    hintText: EditDuaPageTexts.editDuaPageZikirHintText),
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
                          style: EditDuaPageStyles.dataLabelTextStyle(),
                          decoration: InputDecoration(
                            border: EditDuaPageStyles.textFieldBorderStyle(),
                            // labelText: 'পড়তে চাই',
                            // hintText:
                            //     '১০০ (যতবার পড়তে চান সেই সংখ্যাটি লিখুন)'
                            labelText: EditDuaPageTexts
                                .editDuaPageNumberOfTimesWantToReadLabel,
                            hintText: EditDuaPageTexts
                                .editDuaPageNumberOfTimesWantToReadHintText,
                          ),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          // 'বার',
                          EditDuaPageTexts.editDuaPageTimesLabel,
                          style: EditDuaPageStyles.captionLabelTextStyle(),
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
                      style: EditDuaPageStyles.dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: EditDuaPageStyles.textFieldBorderStyle(),
                        // labelText: 'পড়েছি',
                        // hintText:
                        //     '৫০ (যতবার এখন পর্যন্ত পড়েছেন সেই সংখ্যাটি লিখুন)'
                        labelText:
                            EditDuaPageTexts.editDuaPageNumberOfTimesReadLabel,
                        hintText: EditDuaPageTexts
                            .editDuaPageNumberOfTimesReadHintText,
                      ),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      // 'বার',
                      EditDuaPageTexts.editDuaPageTimesLabel,
                      style: EditDuaPageStyles.captionLabelTextStyle(),
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
              // _buildDuaItem(this.context, AddDuaViewModel(), 0),
            ],
          ),
        ),
      );

  Widget _buildAnimatedDuaList() {
    var animatedListView = Consumer<EditDuaPageViewModel>(
      builder:
          (BuildContext context, EditDuaPageViewModel model, Widget child) {
        return AnimatedList(
          key: animatedListKey,
          initialItemCount: model.zikirUIList.length,
          itemBuilder: (BuildContext context, int currentIndex,
              Animation<double> animation) {
            // this._listViewSelectedItemIndex = currentIndex;
            // var selectedData = getDataAt(model.zikirs, currentIndex);
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
    return _buildFullPage();
  }
}
