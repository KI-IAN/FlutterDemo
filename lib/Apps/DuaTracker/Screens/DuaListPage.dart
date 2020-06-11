import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaListFloatingActionButton.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaPageViewModel.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';
import 'package:provider/provider.dart';

class DuaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('দোয়ার তালিকা'),
        backgroundColor: randomColor(),
      ),
      body: ChangeNotifierProvider<DuaPageViewModel>(
          create: (BuildContext context) => DuaPageViewModel(),
          child: DuaListState()),
      floatingActionButton: DuaListFloatingActionButton(),
    );
  }
}

class DuaListState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DuaCardView();
}

class DuaCardView extends State<DuaListState> {
  Widget miniCardTotalCompleted(
          BuildContext context, int currentIndex, DuaPageViewModel model) =>
      Container(
        // alignment: Alignment.center,
        height: 80,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${model.duaList[currentIndex].totalNumberOfTimesZikirRead} / ${model.duaList[currentIndex].totalNumberOfTimesZikirToBeRead}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'বার পড়েছি',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      );

  Widget miniCardTotalDua(
          BuildContext context, int currentIndex, DuaPageViewModel model) =>
      Container(
        // alignment: Alignment.center,
        margin: EdgeInsets.all(0.0),
        height: 80,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${model.duaList[currentIndex].totalZikirsRead} / ${model.duaList[currentIndex].totalZikirs}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'টি দোয়া',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      );

  Widget amolInfo(
          BuildContext context, int currentIndex, DuaPageViewModel model) =>
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'দোয়ার নাম',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '${model.duaList[currentIndex].duaName}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );

  Widget totalProgress() => Container(
        child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: 0.3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
        ),
      );

  Widget amolCard(
          BuildContext context, int currentIndex, DuaPageViewModel model) =>
      Card(
        elevation: 3.0,
        child: SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              amolInfo(context, currentIndex, model),
              Divider(
                color: Colors.lightBlue,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  miniCardTotalDua(context, currentIndex, model),
                  miniCardTotalCompleted(context, currentIndex, model),
                ],
              ),
              // totalProgress,
              Divider(
                color: Colors.lightBlue,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  deleteButton(context, currentIndex, model),
                  editButton(),
                ],
              )
            ],
          ),
        ),
      );

  Widget editButton() => Center(
          child: Ink(
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Colors.lightBlue),
        child: IconButton(
          icon: Icon(Icons.edit),
          alignment: Alignment.center,
          tooltip: 'তথ্য পরিবর্তন করুন',
          color: Colors.white,
          onPressed: () {},
        ),
      ));

  Widget deleteButton(
          BuildContext context, int currentIndex, DuaPageViewModel model) =>
      Center(
          child: Ink(
        decoration:
            const ShapeDecoration(shape: CircleBorder(), color: Colors.red),
        child: IconButton(
          icon: Icon(Icons.delete_forever),
          alignment: Alignment.center,
          tooltip: 'তথ্য মুছুন',
          color: Colors.white,
          onPressed: () {
            _showDeleteAlert(context, currentIndex, model);
          },
        ),
      ));

  Future<void> _showDeleteAlert(
      BuildContext context, int currentIndex, DuaPageViewModel model) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('দোয়া মুছুন'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: _buildAlertBoxDeleteButton(context, model,
                        model.duaList[currentIndex].duaID, currentIndex),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: _buildAlertBoxCancelButton(),
                  )
                ],
              )
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('${model.duaList[currentIndex].duaName} এর ${model.duaList[currentIndex].totalZikirs}' +
                      ' টি জিকির  মুছে ফেলবেন? একবার মুছে ফেলা হলে আর ফেরত পাওয়া যাবে না।'),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildAlertBoxCancelButton() => RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(10),
        color: Colors.lightBlue,
        child: Icon(Icons.cancel, color: Colors.white),
      );

  Widget _buildAlertBoxDeleteButton(BuildContext context,
          DuaPageViewModel model, int duaId, int currentIndex) =>
      RaisedButton(
        onPressed: () {
          Navigator.pop(context);
          model.removeDua(duaId);
          animatedListKey.currentState.removeItem(
              currentIndex,
              (context, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: amolCard(context, currentIndex, model),
                  ),
              duration: Duration(milliseconds: 1 * 500));
        },
        padding: EdgeInsets.all(10),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white),
      );

//region : ListView

  Widget listView() => Consumer<DuaPageViewModel>(
        builder: (context, model, child) {
          return RefreshIndicator(
            onRefresh: model.refreshDuaList,
            child: ListView.builder(
              itemCount: model.duaList.length,
              itemBuilder: (BuildContext context, int index) {
                return amolCard(context, index, model);
              },
              padding: EdgeInsets.all(10.0),
            ),
          );
        },
      );

//endRegion

//region : Animated List

  final GlobalKey<AnimatedListState> animatedListKey =
      GlobalKey<AnimatedListState>();

  Widget _buildAnimatedListView() {
    return Consumer<DuaPageViewModel>(
      builder: (context, model, child) {
        return RefreshIndicator(
          onRefresh: model.refreshDuaList,
          child: AnimatedList(
            key: animatedListKey,
            initialItemCount: model.duaList.length,
            itemBuilder: (BuildContext context, int currentIndex,
                Animation<double> animation) {
              return _buildAmolCardAnimated(
                  context, currentIndex, model, animation);
            },
          ),
        );
      },
    );
  }

  Widget _buildAmolCardAnimated(BuildContext context, int currentIndex,
          DuaPageViewModel model, Animation<double> animation) =>
      SizeTransition(
        sizeFactor: animation,
        child: amolCard(context, currentIndex, model),
      );

//endRegion

  @override
  Widget build(BuildContext context) {
    // return listView();
    return _buildAnimatedListView();
  }
}
