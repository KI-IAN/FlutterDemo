import 'package:fluttertutorial/screen/MVVMTest/Interfaces/INotifyPropertyChanged.dart';

abstract class BaseViewModel{

  INotifyPropertyChanged _widget;

  BaseViewModel(this._widget);

  void RefreshUI() {
    this._widget.InvokeChanges();
  }

}