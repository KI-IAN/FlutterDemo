import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/GeneralAnimationSettings.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Animation/PageTransition.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Screens/DuaListFloatingActionButton.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/ViewModels/DuaListPageFutureProviderVM.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/ViewModels/LanguageChangeViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/EditDua/Pages/EditDuaPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Styles/GeneralStyles.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaListViewModel.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/DuaPageViewModel.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';
import 'package:fswitch/fswitch.dart';
import 'package:provider/provider.dart';

class DuaListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LanguageChangeViewModel().initializeLanguage(context),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<LanguageChangeViewModel>(
              create: (BuildContext context) {
                return snapShot.data;
              },
              child: DuaList());
        } else {
          return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }
}

class DuaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DuaListPageState();
}

class DuaListPageState extends State<DuaList> {
  // bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Consumer<LanguageChangeViewModel>(builder: (context, model, child) {
          return Text(getLanguageText('duaListPage_Title'));
        }),
        backgroundColor: Colors.blueGrey[300],
        actions: <Widget>[
          Visibility(
            visible: false,
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              onPressed: null,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: FSwitch(
              openColor: Colors.blueGrey[400],
              color: Colors.blueGrey[400],
              sliderColor: Colors.white60,
              // sliderColor: randomColor(),
              width: 90,
              height: 36,
              open: Provider.of<LanguageChangeViewModel>(context, listen: false)
                  .switchValue,
              onChanged: (value) async {
                await Provider.of<LanguageChangeViewModel>(context,
                        listen: false)
                    .resetLanguageFile(value, context);
              },
              closeChild: Text(
                "English",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              openChild: Text(
                "বাংলা",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<LanguageChangeViewModel>(
        builder: (context, model, child) {
          return FutureBuilder(
            future: DuaListPageFutureProviderVM().getDuaListPageData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ChangeNotifierProvider<DuaPageViewModel>(
                  create: (context) => snapshot.data,
                  child: DuaListState(),
                );
              } else {
                return Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              }
            },
          );
        },
        // child:
      ),
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
              '${data.totalNumberOfTimesZikirRead} / ${data.totalNumberOfTimesZikirToBeRead}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              getLanguageText('duaListPage_totalReadCount'),
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
              '${data.totalZikirsRead} / ${data.totalZikirs}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              getLanguageText('duaListPage_totalZikir').toString(),
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
              getLanguageText('duaListPage_duaName'),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '${data.shortenDuaName}',
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
          splashColor: GeneralStyles.buttonSplashColor(),
          icon: Icon(Icons.edit),
          alignment: Alignment.center,
          tooltip: getLanguageText('duaListPage_editDataTooltip'),
          color: Colors.white,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();

            Navigator.of(context)
                .push(PageTransition().createRoute(EditDuaPage(duaID)));
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
          splashColor: GeneralStyles.buttonSplashColor(),
          icon: Icon(Icons.delete_forever),
          alignment: Alignment.center,
          tooltip: getLanguageText('duaListPage_deleteDataTooltip'),
          color: Colors.white,
          onPressed: () async {
            await GeneralAnimationSettings.buttonTapDelay();
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
            title: Text(getLanguageText('duaListPage_deleteDuaButton')),
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
                  Text(getLanguageText('duaListPage_deleteDuaAlert')
                      .toString()
                      .replaceAll('[DuaName]', '${data.duaName}')
                      .replaceAll('[totalZikirCount]', '${data.totalZikirs}')
                      .replaceAll(
                          '[pluralForm]', "${data.totalZikirs > 1 ? 's' : ''}"))
                ],
              ),
            ),
          );
        });
  }

  Widget _buildAlertBoxCancelButton() => RaisedButton(
        onPressed: () async {
          await GeneralAnimationSettings.buttonTapDelay();
          Navigator.pop(this.context);
        },
        padding: EdgeInsets.all(10),
        color: Colors.lightBlue,
        child: Icon(Icons.cancel, color: Colors.white),
      );

  Widget _buildAlertBoxDeleteButton(BuildContext context, int duaId,
          int currentIndex, DuaListViewModel data) =>
      RaisedButton(
        onPressed: () async {
          await GeneralAnimationSettings.buttonTapDelay();
          Provider.of<DuaPageViewModel>(this.context, listen: false)
              .removeDua(duaId);
          Navigator.pop(context);
          animatedListKey.currentState.removeItem(
            currentIndex,
            (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: amolCard(context, currentIndex, data),
            ),
            // duration: Duration(milliseconds: 1 * 700)
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
    return _buildAnimatedListView();
  }
}
