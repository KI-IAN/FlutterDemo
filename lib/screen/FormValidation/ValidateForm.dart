import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidateFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation'),
      ),
      body: ValidateForm(),
    );
  }
}

class ValidateForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ValidateFormState();
}

class ValidateFormState extends State<ValidateForm> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Your Name....',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10)))),
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              }
              return null;
            },
            decoration:
                InputDecoration(labelText: 'Name', hintText: 'Your Name....'),
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              }
              return null;
            },
            decoration:
                InputDecoration(labelText: 'Name', hintText: 'Your Name....'),
          ),
          TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name cannot be empty';
              }
              return null;
            },
            decoration:
                InputDecoration(labelText: 'Name', hintText: 'Your Name....'),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              _formState.currentState.validate();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      key: _formState,
      child: _buildForm(),
    );
  }
}
