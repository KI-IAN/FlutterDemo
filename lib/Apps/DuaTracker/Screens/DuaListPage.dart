import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/AmalListFloatingActionButton.dart';
import 'package:fluttertutorial/PubPackages/CircularText/CircularText.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';

class DuaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('দোয়ার তালিকা'),
        backgroundColor: randomColor(),
      ),
      body: DuaListState(),
      floatingActionButton: AmalListFloatingActionButton(),
    );
  }
}

class DuaListState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DuaCardView();
}

class DuaCardView extends State<DuaListState> {
  Widget miniCardTotalCompleted() => Container(
        // alignment: Alignment.center,
        height: 80,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '৩০ / ২০০',
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

  Widget miniCardTotalDua() => Container(
        // alignment: Alignment.center,
        margin: EdgeInsets.all(0.0),
        height: 80,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '১ / ৩',
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

  Widget amolInfo() => Container(
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
              'সূরা আল বাকারা',
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

  Widget amolCard() => Card(
        elevation: 3.0,
        child: SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              amolInfo(),
              Divider(
                color: Colors.lightBlue,
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  miniCardTotalDua(),
                  miniCardTotalCompleted(),
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
                  editButton(),
                  deleteButton(),
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

  Widget deleteButton() => Center(
          child: Ink(
        decoration:
            const ShapeDecoration(shape: CircleBorder(), color: Colors.red),
        child: IconButton(
          icon: Icon(Icons.delete_forever),
          alignment: Alignment.center,
          tooltip: 'তথ্য মুছুন',
          color: Colors.white,
          onPressed: () {
            _showDeleteAlert();
          },
        ),
      ));

  Future<void> _showDeleteAlert() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('দোয়া মুছুন'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'এই দোয়াগুলো মুছে ফেলবেন? একবার মুছে ফেলা হলে আর ফেরত পাওয়া যাবে না।'),
                ],
              ),
            ),
          );
        });
  }

//region : ListView

  static List<String> data = <String>['', '', '', '', '', '', '', '', '', ''];

  Widget listView() => ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return amolCard();
        },
        padding: EdgeInsets.all(10.0),
      );

//endRegion

  @override
  Widget build(BuildContext context) {
    return listView();
  }
}
