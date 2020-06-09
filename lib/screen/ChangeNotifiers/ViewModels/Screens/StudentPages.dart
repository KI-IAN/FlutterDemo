import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/ChangeNotifiers/ViewModels/StudentModel.dart';
import 'package:provider/provider.dart';

class StudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Notifier Provider'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => StudentModel(),
        child: StudentPage(),
      ),
    );
  }
}

class StudentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StudentCN();
}

class _StudentCN extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          textDirection: TextDirection.ltr,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            Provider.of<StudentModel>(context, listen: false).Id =
                int.parse(value);
          },
          decoration: InputDecoration(
              hintText: 'Student ID',
              fillColor: randomColor(),
              focusColor: randomColor()),
        ),
        Text(
          'Student ID : ',
          style: TextStyle(color: randomColor()),
        ),
        Consumer<StudentModel>(
          builder: (context, value, child) {
            return Row(
              children: <Widget>[
                Text(
                  '${value.Id}',
                  style: TextStyle(color: randomColor()),
                ),
              ],
            );
          },
        ),
        Row(
          children: <Widget>[
            Text('Student Height (Provider) : ', style: TextStyle(backgroundColor: randomColor()),),
            Text('${Provider.of<StudentModel>(context, listen: false).Height}', style: TextStyle(backgroundColor: randomColor()),)
          ],
        ),
        Consumer<StudentModel>(
          builder: (context, model, child) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 10 * 100),
              margin: EdgeInsets.all(model.Radius),
              child: SizedBox(
                width: model.Width,
                height: model.Height,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: randomColor(),
                  ),
                ),
              ),
              curve: Curves.easeIn,
            );
          },
        ),
        Consumer<StudentModel>(
          builder: (context, model, child) {
            return SizedBox(
                height: model.Height,
                width: model.Width,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 10 * 100),
                  margin: EdgeInsets.all(model.Radius),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: randomColor(),
                  ),
                  curve: Curves.easeIn,
                ));
          },
        ),
        RaisedButton(
          child: Text('Submit'),
          color: randomColor(),
          onPressed:
              Provider.of<StudentModel>(context, listen: false).animateButton,
        ),
        RaisedButton(
          child: Text('Rebuild UI'),
          onPressed: rebuildWholeWidget,
        ),
      ],
    );
  }

  Color randomColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }

  void rebuildWholeWidget() {
    setState(() {});
  }
}
