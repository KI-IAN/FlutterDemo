import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Constants/LanguageFilePath.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/Screens/DuaListPage.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Screens/DuaList/ViewModels/LanguageChangeViewModel.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';
import 'package:fluttertutorial/PubPackages/CircularText/CircularText.dart';
import 'package:fluttertutorial/screen/AnimatedList/AnimatedListApp.dart';
import 'package:fluttertutorial/screen/ChangeNotifiers/ViewModels/Screens/StudentPages.dart';
import 'package:fluttertutorial/screen/ChangeNotifiers/ViewModels/StudentModel.dart';
import 'package:fluttertutorial/screen/CustomShapes/Sky.dart';
import 'package:fluttertutorial/screen/ExplicitAnimation/TransformAnimation.dart';
import 'package:fluttertutorial/screen/FormValidation/ValidateForm.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/AnimatedContainerDemo.dart';
import 'package:fluttertutorial/screen/ImplicitAnimation/FadeInDemo.dart';
import 'package:fluttertutorial/screen/Layouts/BottomNavigationBar.dart';
import 'package:fluttertutorial/screen/Layouts/CardDemo.dart';
import 'package:fluttertutorial/screen/Layouts/CompleteLayout.dart';
import 'package:fluttertutorial/screen/Layouts/ConstraintsDemo.dart';
import 'package:fluttertutorial/screen/CustomShapes/CustomShapeApp.dart';
import 'package:fluttertutorial/screen/Layouts/GridViewDemos.dart';
import 'package:fluttertutorial/screen/Layouts/NestedRowColumns.dart';
import 'package:fluttertutorial/screen/Layouts/NonMaterialApp.dart';
import 'package:fluttertutorial/screen/Layouts/PackingWidget.dart';
import 'package:fluttertutorial/screen/Layouts/RowColumnDemo.dart';
import 'package:fluttertutorial/screen/Layouts/StackDemo.dart';
import 'package:fluttertutorial/screen/ListViewDemo/ListViewBuilder.dart';
import 'package:fluttertutorial/screen/ListViewDemo/ListViewSeparator.dart';
import 'package:fluttertutorial/screen/ListViewDemo/SimpleListView.dart';
import 'package:fluttertutorial/screen/ListViewDemo/ViewModels/ListViewMVVM.dart';
import 'package:fluttertutorial/screen/MVVMTest/StudentPage.dart';
import 'package:fluttertutorial/screen/MyAppBar.dart';
import 'package:fluttertutorial/screen/MyButton.dart';
import 'package:fluttertutorial/screen/MyScaffold.dart';
import 'package:fluttertutorial/screen/NavigationAnimation/AnimatingPageRouting.dart';
import 'package:fluttertutorial/screen/SqfLite/DBHelper/DB.dart';
import 'package:fluttertutorial/screen/SqfLite/Screens/MyToDoPage.dart';
import 'package:fluttertutorial/screen/TutorialHome.dart';
import 'package:fluttertutorial/screen/Counter.dart';
import 'package:fluttertutorial/screen/lakes/MyLakeApp.dart';
import 'package:fluttertutorial/screen/TapBox/MyTapBoxAApp.dart';
import 'package:fluttertutorial/screen/Navigation/ForthBack/FirstRoute.dart';

import 'package:provider/provider.dart';

import 'screen/CustomShapes/CustomShapeApp.dart';
import 'package:flutter/widgets.dart';

//void main() async {
//
//  WidgetsFlutterBinding.ensureInitialized();
//
//  await DB.init();
//  runApp(MyApp());
//}

//region: Change Notifier

//void main(){
//  runApp(
//    ChangeNotifierProvider(
//      create: (context) => StudentModel(),
//      child: MaterialApp(
//        title: 'Change Notifier',
//        home: StudentApp(),
//      ),
//    ),
//  );
//}

//
//void main(){
//  runApp(NonMaterialApp());
//}

void main() async {
  // runApp(MyApp());

  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Change Notifier',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Atma'),
    // home: RowColumnDemo(),
    // home: MainPage('Bottom Navigation Bar', BottomNavigationBarDemo()),
    // home: BottomNavigationBarApp(),
    // home : TransformAnimationApp(),
    // home: AddDuaPage(),
    // child: DuaListPage()),
    // home: Page1(),
    // home: ValidateFormPage(),
    // home: AnimatedListApp(),
    // home: CircularTextPage(),
    home: DuaListPage(),
  ));
}

//endregion

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MyToDoPage(title: 'Flutter SQLite Demo App'),
    );
  }
}

//void main() {
//  runApp(MaterialApp(
//    debugShowCheckedModeBanner: false,
//    title: '',
////    home: StudentPage(),
//    home: MainPage('Shape Shifting', AnimatedContainerDemo()),
//    theme: ThemeData(primarySwatch: Colors.lightGreen),
//  ));
//}

class MainPage extends StatelessWidget {
  MainPage(this._title, this._body);

  final Widget _body;
  String _title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
      ),
      body: _body,
    );
  }
}
