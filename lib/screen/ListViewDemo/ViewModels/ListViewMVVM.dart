import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertutorial/screen/ListViewDemo/PersonRepository.dart';
import 'package:fluttertutorial/screen/ListViewDemo/ViewModels/PersonViewModel.dart';

class ListViewMVVM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersonViewModel persons = PersonViewModel();
    var personData = PersonRepository().getAll();

    var listView = ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.vertical,
      itemCount: personData.length,
      itemBuilder: (context, index) {
        var itemTemplate = Container(
          child: Card(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('${personData[index].FirstName}'),
                    ),
                    Expanded(
                      child: Text('${personData[index].LastName}'),
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('${personData[index].Age}'),
                    ),

                    Switch(
                      value: personData[index].IsCareLess,
                      activeColor: Colors.lightGreen,
                      onChanged: (value) {
                        
                      },
                    )

                  ],
                ),
              ],
            ),
          ),
        );

        return itemTemplate;
      },
    );

    return listView;
  }
}
