import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
 
  void invokeChanges() {
    notifyListeners();
  }


}
