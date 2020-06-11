import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/AddDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/ZikirViewModel.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';
import 'package:provider/provider.dart';

class AddDuaPage extends StatelessWidget {
  Widget _buildAppBar() => AppBar(
        title: Text('নতুন দোয়া'),
        backgroundColor: randomColor(),
      );

  Widget _buildFloatingActionButton(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.red,
              padding: EdgeInsets.all(12),
              child: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: RaisedButton(
              onPressed: () {},
              padding: EdgeInsets.all(12),
              color: Colors.lightBlue,
              child: Icon(Icons.save, color: Colors.white),
            ),
          ),
        ],
      );

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

  Widget _buildDuaContainer() => Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<AddDuaViewModel>(this.context).dua.name =
                            value;
                      },
                      style: _dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: _textFieldBorderStyle(),
                        // focusedBorder: InputBorder.none,
                        // enabledBorder: InputBorder.none,
                        // errorBorder: InputBorder.none,
                        // disabledBorder: InputBorder.none,
                        labelText: 'দোয়ার নাম',
                        // contentPadding: EdgeInsets.all(10)
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
          children: <Widget>[
            Expanded(
              child: Text(
                'এখনো কোন জিকির নেই। নতুন জিকির তৈরি করি।',
                style: _secondaryCaptionTextStyle(),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.lightGreen,
                ),
                onPressed: () {
                  Provider.of<AddDuaViewModel>(this.context, listen: false)
                      .addNewZikirInList();
                  animatedListKey.currentState.insertItem(
                      Provider.of<AddDuaViewModel>(this.context, listen: false)
                              .zikirs
                              .length -
                          1);
                })
          ],
        ),
      );

  Widget _buildDuaItem(
      BuildContext context, int currentIndex, ZikirViewModel data) {
    return Container(
      child: Card(
        color: (currentIndex % 2 == 0) ? Colors.white : Colors.yellow[50],
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: TextEditingController(
                  text: data.zikirName,
                ),
                onChanged: (String value) {
                  // model.zikirs[currentIndex].zikirName = value;
                  Provider.of<AddDuaViewModel>(context, listen: false)
                      .zikirs[currentIndex]
                      .zikirName = value;
                },
                style: _dataLabelTextStyle(),
                decoration: InputDecoration(
                  border: _textFieldBorderStyle(),
                  labelText: 'জিকিরের নাম (${data.zikirName})',
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
                          controller: TextEditingController(
                            text: data.numberOfTimesWantToRead.toString(),
                          ),
                          onChanged: (value) {
                            Provider.of<AddDuaViewModel>(context, listen: false)
                                .zikirs[currentIndex]
                                .numberOfTimesWantToRead = int.parse(value);
                          },
                          keyboardType: TextInputType.text,
                          style: _dataLabelTextStyle(),
                          decoration: InputDecoration(
                            labelText: 'পড়তে চাই',
                            border: _textFieldBorderStyle(),
                          ),
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
                      controller: TextEditingController(
                        text: data.numberOfTimesRead.toString(),
                      ),
                      onChanged: (value) {
                        Provider.of<AddDuaViewModel>(context, listen: false)
                            .zikirs[currentIndex]
                            .numberOfTimesRead = int.parse(value);
                      },
                      keyboardType: TextInputType.text,
                      style: _dataLabelTextStyle(),
                      decoration: InputDecoration(
                        border: _textFieldBorderStyle(),
                        labelText: 'পড়েছি',
                      ),
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
        child: Column(
          children: <Widget>[
            _buildDuaContainer(),
            _buildAddZikirContainer(),

            Expanded(child: _buildAnimatedDuaList()),
            // _buildDuaItem(this.context, AddDuaViewModel(), 0),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildFullPage();
  }

  ZikirViewModel getDataAt(List<ZikirViewModel> data, int selectedIndex) {
    var selectedData = data.elementAt(selectedIndex);
    return selectedData;
  }
}
