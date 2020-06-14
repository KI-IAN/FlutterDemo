import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaListFloatingActionButton.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Pages/EditDuaPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaListViewModel.dart';
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
  Widget miniCardTotalCompleted(BuildContext context, DuaListViewModel data) =>
      Container(
        // alignment: Alignment.center,
        height: 80,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              // '${model.duaList[currentIndex].totalNumberOfTimesZikirRead} / ${model.duaList[currentIndex].totalNumberOfTimesZikirToBeRead}',
              '${data.totalNumberOfTimesZikirRead} / ${data.totalNumberOfTimesZikirToBeRead}',
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

  Widget miniCardTotalDua(BuildContext context, DuaListViewModel data) =>
      Container(
        // alignment: Alignment.center,
        margin: EdgeInsets.all(0.0),
        height: 80,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              // '${model.duaList[currentIndex].totalZikirsRead} / ${model.duaList[currentIndex].totalZikirs}',
              '${data.totalZikirsRead} / ${data.totalZikirs}',
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

  Widget amolInfo(BuildContext context, DuaListViewModel data) => Container(
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
              // '${model.duaList[currentIndex].duaName}',
              '${data.duaName}',
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
          BuildContext context, int currentIndex, DuaListViewModel data) =>
      Card(
        elevation: 3.0,
        child: SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              amolInfo(context, data),
              Divider(
                color: Colors.lightBlue,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  miniCardTotalDua(context, data),
                  miniCardTotalCompleted(context, data),
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
                  deleteButton(context, currentIndex, data),
                  editButton(data.duaID),
                ],
              )
            ],
          ),
        ),
      );

  Widget editButton(int duaID) => Center(
          child: Ink(
        decoration: const ShapeDecoration(
            shape: CircleBorder(), color: Colors.lightBlue),
        child: IconButton(
          icon: Icon(Icons.edit),
          alignment: Alignment.center,
          tooltip: 'তথ্য পরিবর্তন করুন',
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(PageTransition().createRoute(EditDuaPage(duaID)));
          },
        ),
      ));

  Widget deleteButton(
          BuildContext context, int currentIndex, DuaListViewModel data) =>
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
            _showDeleteAlert(context, currentIndex, data);
          },
        ),
      ));

  Future<void> _showDeleteAlert(
      BuildContext context, int currentIndex, DuaListViewModel data) async {
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
                    child: _buildAlertBoxDeleteButton(
                        context, data.duaID, currentIndex, data),
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
                  Text('${data.duaName} এর ${data.totalZikirs}' +
                      ' টি জিকির  মুছে ফেলবেন? একবার মুছে ফেলা হলে আর ফেরত পাওয়া যাবে না।'),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildAlertBoxCancelButton() => RaisedButton(
        onPressed: () {
          Navigator.pop(this.context);
        },
        padding: EdgeInsets.all(10),
        color: Colors.lightBlue,
        child: Icon(Icons.cancel, color: Colors.white),
      );

  Widget _buildAlertBoxDeleteButton(BuildContext context, int duaId,
          int currentIndex, DuaListViewModel data) =>
      RaisedButton(
        onPressed: () {
          Navigator.pop(context);
          Provider.of<DuaPageViewModel>(this.context, listen: false)
              .removeDua(duaId);
          animatedListKey.currentState.removeItem(
              currentIndex,
              (context, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: amolCard(context, currentIndex, data),
                  ),
              duration: Duration(milliseconds: 1 * 700)
              );
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
                var currentItem = getDataAt(model, index);
                return amolCard(context, index, currentItem);
              },
              padding: EdgeInsets.all(10.0),
            ),
          );
        },
      );

//endRegion

//region : Get Data by index

  DuaListViewModel getDataAt(DuaPageViewModel model, int index) {
    var duaData = model.duaList.elementAt(index);
    return duaData;
  }

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
              var currentItem = model.duaList.elementAt(currentIndex);

              return _buildAmolCardAnimated(
                  context, currentIndex, model, animation, currentItem);
            },
          ),
        );
      },
    );
  }

  Widget _buildAmolCardAnimated(
      BuildContext context,
      int currentIndex,
      DuaPageViewModel model,
      Animation<double> animation,
      DuaListViewModel data) {
    return SizeTransition(
      sizeFactor: animation,
      child: amolCard(context, currentIndex, data),
    );
  }

//endRegion

  @override
  Widget build(BuildContext context) {
    // return listView();
    return _buildAnimatedListView();
  }
}
