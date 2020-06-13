import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaListPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/AddDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/ZikirViewModel.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

//region : Validation Logic (Should find a better maintainable way)
final addDuaFormState = GlobalKey<FormState>();

final addZikirFormState = GlobalKey<FormState>();

//endRegion

class AddDuaPage extends StatelessWidget {
  BuildContext _currentContext;

  Widget _buildAppBar() => AppBar(
        title: Text('নতুন দোয়া'),
        backgroundColor: randomColor(),
      );

  Widget _buildFloatingActionButton(BuildContext context) {
    this._currentContext = context;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.all(5),
        //   child: RaisedButton(
        //     onPressed: goBackToDuaListPage,
        //     color: Colors.red,
        //     padding: EdgeInsets.all(12),
        //     child: Icon(
        //       Icons.cancel,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.all(5),
        //   child: RaisedButton(
        //     onPressed: saveDua,
        //     padding: EdgeInsets.all(12),
        //     color: Colors.lightGreen,
        //     child: Icon(Icons.save, color: Colors.white),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.all(0),
          child: FloatingActionButton(
            onPressed: saveDua,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
            backgroundColor: Colors.lightGreen,
          ),
        )
      ],
    );
  }

  Widget _buildScaffold(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        floatingActionButton: _buildFloatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

      
      //To know how it works : https://stackoverflow.com/questions/45889341/flutter-remove-all-routes
      Navigator.pushAndRemoveUntil(
          _currentContext,
          MaterialPageRoute(builder: (context) => DuaListPage()),
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
  //region : Styling
  TextStyle _dataLabelTextStyle() =>
      TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.w500);

  TextStyle _captionLabelTextStyle() =>
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);

  TextStyle _secondaryCaptionTextStyle() =>
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);

  OutlineInputBorder _textFieldBorderStyle() => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        borderSide: BorderSide(color: Colors.lightBlue),
      );
  //endRegion

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
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'দোয়ার নাম আবশ্যক'),
                        MinLengthValidator(1,
                            errorText:
                                'দোয়ার নাম অন্তত এক অক্ষর বিশিষ্ট হতে হবে'),
                        MaxLengthValidator(10,
                            errorText:
                                'দোয়ার নাম ১০  অক্ষরের বেশি হতে পারবে না'),
                      ]),
                      controller: TextEditingController(
                          text: Provider.of<AddDuaViewModel>(context,
                                  listen: false)
                              .dua
                              .name),
                      onChanged: (value) {
                        Provider.of<AddDuaViewModel>(this.context).dua.name =
                            value;
                      },
                      style: _dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: _textFieldBorderStyle(),
                        labelText: 'দোয়ার নাম',
                        hintText: 'দোয়া কেন পড়ছেন সেই কারণটির নাম লিখুন',
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
                      'মোট জিকির',
                      style: _captionLabelTextStyle(),
                    ),
                  ),
                  Consumer<AddDuaViewModel>(
                    builder: (context, model, child) {
                      return Expanded(
                          child: Text(
                        '${model.totalZikirs}',
                        style: _dataLabelTextStyle(),
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
                  'এখনো কোন জিকির নেই। নতুন জিকির তৈরি করি।',
                  style: _secondaryCaptionTextStyle(),
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

  Future<void> _showAddZikirForm(
      BuildContext parentContext, ZikirViewModel zikirdata) async {
    return showGeneralDialog<void>(
        //Default context is different for GeneralDialog than its caller.
        //In ordeer to be able to access same Provider data, we have to replace
        //the original context of GeneralDialog with the caller Build Context
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
                style: _dataLabelTextStyle(),
                decoration: InputDecoration(
                    border: _textFieldBorderStyle(),
                    labelText: 'জিকিরের নাম',
                    hintText: 'সূরার নাম'),
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
                          style: _dataLabelTextStyle(),
                          decoration: InputDecoration(
                              labelText: 'পড়তে চাই',
                              border: _textFieldBorderStyle(),
                              hintText:
                                  '১০০ (যতবার পড়তে চান সেই সংখ্যাটি লিখুন)'),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          'বার',
                          style: _captionLabelTextStyle(),
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
                      style: _dataLabelTextStyle(),
                      decoration: InputDecoration(
                          border: _textFieldBorderStyle(),
                          labelText: 'পড়েছি',
                          hintText:
                              '৫০ (যতবার এখন পর্যন্ত পড়েছেন সেই সংখ্যাটি লিখুন)'),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      'বার',
                      style: _captionLabelTextStyle(),
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
                validator: MultiValidator([
                  RequiredValidator(errorText: 'জিকিরের নাম আবশ্যক'),
                  MinLengthValidator(1,
                      errorText: 'জিকিরের নাম অন্তত এক অক্ষর বিশিষ্ট হতে হবে'),
                  MaxLengthValidator(10,
                      errorText: 'জিকিরের নাম ১০  অক্ষরের বেশি হতে পারবে না'),
                ]),
                controller: TextEditingController(
                  text: data.zikirName,
                ),
                onChanged: (String value) {
                  // model.zikirs[currentIndex].zikirName = value;
                  // Provider.of<AddDuaViewModel>(context, listen: false)
                  //     .zikirs[currentIndex]
                  //     .zikirName = value;
                  Provider.of<AddDuaViewModel>(context, listen: false)
                      .temporaryZikirData
                      .zikirName = value;
                },
                style: _dataLabelTextStyle(),
                decoration: InputDecoration(
                    border: _textFieldBorderStyle(),
                    labelText: 'জিকিরের নাম',
                    hintText: 'সূরার নাম'),
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
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'আবশ্যক'),
                            RangeValidator(
                                min: 1,
                                max: 999,
                                errorText: '১ - ৯৯৯ এর মাঝে যে কোন সংখ্যা')
                          ]),
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead?.toString(),
                          ),
                          onChanged: (value) {
                            // Provider.of<AddDuaViewModel>(context, listen: false)
                            //     .zikirs[currentIndex]
                            //     .numberOfTimesWantToRead = int.parse(value);
                            Provider.of<AddDuaViewModel>(context, listen: false)
                                .temporaryZikirData
                                .numberOfTimesWantToRead = int.parse(value);
                          },
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: _dataLabelTextStyle(),
                          decoration: InputDecoration(
                              labelText: 'পড়তে চাই',
                              border: _textFieldBorderStyle(),
                              hintText:
                                  '১০০ (যতবার পড়তে চান সেই সংখ্যাটি লিখুন)'),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: Text(
                          'বার',
                          style: _captionLabelTextStyle(),
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'আবশ্যক'),
                      ]),
                      controller: TextEditingController(
                        text: data.numberOfTimesRead?.toString(),
                      ),
                      onChanged: (value) {
                        // Provider.of<AddDuaViewModel>(context, listen: false)
                        //     .zikirs[currentIndex]
                        //     .numberOfTimesRead = int.parse(value);
                        Provider.of<AddDuaViewModel>(context, listen: false)
                            .temporaryZikirData
                            .numberOfTimesRead = int.parse(value);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      style: _dataLabelTextStyle(),
                      decoration: InputDecoration(
                          border: _textFieldBorderStyle(),
                          labelText: 'পড়েছি',
                          hintText:
                              '৫০ (যতবার এখন পর্যন্ত পড়েছেন সেই সংখ্যাটি লিখুন)'),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      'বার',
                      style: _captionLabelTextStyle(),
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
          tooltip: 'তথ্য সংরক্ষণ করুন',
          color: Colors.white,
          onPressed: () {
            // print('currentIndex : $currentIndex');

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
          tooltip: 'তথ্য মুছুন',
          color: Colors.white,
          onPressed: () {
            print('currentIndex : $currentIndex');

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

  Widget _buildDuaList() {
    var listView = Consumer<AddDuaViewModel>(
      builder: (context, model, child) {
        return ListView.builder(
            itemCount: model.zikirs.length,
            itemBuilder: (BuildContext context, int currentIndex) {
              var currentData = getDataAt(model.zikirs, currentIndex);
              return _buildDuaItem(context, currentIndex, currentData);
            });
      },
    );

    return listView;
  }

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
              // _buildDuaItem(this.context, AddDuaViewModel(), 0),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    this._currentContext = context;
    return _buildFullPage();
  }

  ZikirViewModel getDataAt(List<ZikirViewModel> data, int selectedIndex) {
    var selectedData = data.elementAt(selectedIndex);
    return selectedData;
  }
}
