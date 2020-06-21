import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Constants/LanguageFilePath.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/LanguageEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';

class LanguageChangeViewModel extends BaseViewModel {
  bool _switchValue = true;

  bool get switchValue => this._switchValue;

  LanguageEnum get selectedLanguage {
    LanguageEnum selectedLanguage =
        _switchValue ? LanguageEnum.Bangla : LanguageEnum.English;
    return selectedLanguage;
  }

  Future<void> resetLanguageFile(bool switchValue, BuildContext context) async {
    this._switchValue = switchValue;

    var languageFilePath = this.selectedLanguage == LanguageEnum.Bangla
        ? LanguageFilePath.bangla
        : LanguageFilePath.english;

    await MultiLanguage.resetLanguage(path: languageFilePath, context: context);

    this.invokeChanges();
  }

  Future<void> initializeLanguage(BuildContext context) async {
    await MultiLanguage.setLanguage(
        path: LanguageFilePath.english, context: context);
  }
}
