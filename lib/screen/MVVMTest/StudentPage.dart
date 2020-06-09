import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/MVVMTest/Interfaces/INotifyPropertyChanged.dart';
import 'package:fluttertutorial/screen/MVVMTest/Interfaces/NotifyPropertyChanged.dart';
import 'package:fluttertutorial/screen/MVVMTest/StudentViewModel.dart';

class StudentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Student();


}

class Student extends State<StudentPage> {
  StudentViewModel _studentModel;
  INotifyPropertyChanged _iNotifyPropertyChanged;

  Student() {
    _iNotifyPropertyChanged = NotifyPropertyChanged(this);
    _studentModel = StudentViewModel(_iNotifyPropertyChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MVVM'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (value) => _studentModel.Id = int.parse(value),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Student ID',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Student ID: '),
              ),
              Expanded(
                child: Text('${_studentModel.Id}'),
              ),
            ],
          ),
          TextField(
            onChanged: (value) => _studentModel.FirstName = value,
            decoration: InputDecoration(
              hintText: 'Student First Name',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Student First Name: '),
              ),
              Expanded(
                child: Text('${_studentModel.FirstName}'),
              ),
            ],
          ),
          TextField(
            onChanged: (value) => _studentModel.LastName = value,
            decoration: InputDecoration(
              hintText: 'Student Last Name',
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Student Last Name: '),
              ),
              Expanded(
                child: Text('${_studentModel.LastName}'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Student Full Name: '),
              ),
              Expanded(
                child: Text('${_studentModel.FullName}'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('Date of Birth'),
              ),
              Expanded(
                child: InputDatePickerFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now(),
                ),
              )
            ],
          ),
          Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Text('Item#A'),
                  Text('Item#B'),
                  Text('Item#C'),
                  Text('Item#D'),
                ],
              )),
        ],
      ),
    );
  }
}
