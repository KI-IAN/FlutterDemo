import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:fluttertutorial/screen/ListViewDemo/ViewModels/PersonViewModel.dart';

class PersonRepository {
  PersonViewModel _personViewModel;

  PersonRepository();

  List<PersonViewModel> getAll() {
    List<PersonViewModel> persons = List<PersonViewModel>();

    final _random = new Random();

    for (int index = 0; index <= 10; index++) {
      PersonViewModel personData = PersonViewModel();
      personData.FirstName = 'FName# ${index}';
      personData.LastName = 'LName# ${index}';
      personData.Age = _random.nextInt(35);
      personData.IsCareLess = (index % 2 == 0);

      persons.add(personData);
    }

//      persons[index]
//        ..FirstName = 'FName# ${index}'
//        ..LastName = 'LName# ${index}'
//        ..Age = _random.nextInt(35)
//        ..IsCareLess = (index % 2 == 0);
//    }

    return persons;
  }
}
