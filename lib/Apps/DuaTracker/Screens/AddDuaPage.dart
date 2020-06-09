import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/AddDuaViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';
import 'package:path/path.dart';
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
          // FloatingActionButton(
          //   onPressed: () {},
          //   backgroundColor: Colors.lightGreen,
          //   child: Icon(Icons.add),
          // ),
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
                })
          ],
        ),
      );

  Widget _buildDuaItem(BuildContext context, int currentIndex,
          [AddDuaViewModel model]) =>
      Container(
        child: Card(
          // color: (currentIndex % 2 == 0) ? Colors.white : Colors.yellow[50],
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  // initialValue:
                  //     Provider.of<AddDuaViewModel>(context, listen: false)
                  //         .zikirs[currentIndex]
                  //         .zikirName,
                  initialValue: model.zikirs[currentIndex].zikirName,
                  onChanged: (String value) {
                    // model.zikirs[currentIndex].zikirName = value;
                    Provider.of<AddDuaViewModel>(context, listen: false)
                        .zikirs[currentIndex]
                        .zikirName = value;
                  },
                  style: _dataLabelTextStyle(),
                  decoration: InputDecoration(
                    border: _textFieldBorderStyle(),
                    labelText:
                        'জিকিরের নাম (${Provider.of<AddDuaViewModel>(context, listen: false).zikirs[currentIndex].zikirName})',
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
                            onChanged: (value) {
                              // model.zikirs[currentIndex]
                              //     .numberOfTimesWantToRead = int.parse(value);
                              Provider.of<AddDuaViewModel>(context,
                                      listen: false)
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
                  child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            onChanged: (value) {
                              // model.zikirs[currentIndex].numberOfTimesRead =
                              //     int.parse(value);
                              Provider.of<AddDuaViewModel>(context,
                                      listen: false)
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
            Provider.of<AddDuaViewModel>(this.context, listen: false)
                .removeZikirFromList(currentIndex);
          },
        ),
      ));

  Widget _buildDuaList() {
    var listView = Consumer<AddDuaViewModel>(
      builder: (context, model, child) {
        return ListView.builder(
            itemCount: model.zikirs.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildDuaItem(context, index, model);
            });
      },
    );

    return listView;
  }

  Widget _buildFullPage() => Container(
        child: Column(
          children: <Widget>[
            _buildDuaContainer(),
            _buildAddZikirContainer(),
            // _buildDuaItem(),
            Expanded(child: _buildDuaList()),
            // _buildDuaItem(this.context, AddDuaViewModel(), 0),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return _buildFullPage();
  }
}
