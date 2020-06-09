import 'package:flutter/widgets.dart';
import 'package:fluttertutorial/screen/MVVMTest/Interfaces/INotifyPropertyChanged.dart';

class NotifyPropertyChanged<T extends StatefulWidget>
    implements INotifyPropertyChanged {


  State<T> _widgetState;

  NotifyPropertyChanged(this._widgetState);

  @override
  void InvokeChanges() {
    _widgetState.setState(() {});
  }
}
