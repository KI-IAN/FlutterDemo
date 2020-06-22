import 'package:flutter/material.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Constants/LanguageFilePath.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/LanguageEnum.dart';
import 'package:fluttertutorial/Apps/DuaTracker/Enums/LanguageNames.dart';
import 'package:fluttertutorial/Apps/DuaTracker/ViewModels/BaseViewModel.dart';
import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeViewModel extends BaseViewModel {
  bool _switchValue = true;

  bool get switchValue => this._switchValue;

  set switchValue(value) => this._switchValue = value;

  LanguageEnum get selectedLanguage {
    LanguageEnum selectedLanguage =
        _switchValue ? LanguageEnum.Bangla : LanguageEnum.English;
    return selectedLanguage;
  }

  Future<void> resetLanguageFile(bool switchValue, BuildContext context) async {
    this._switchValue = switchValue;

    var languageFilePath = (this.selectedLanguage == LanguageEnum.Bangla)
        ? LanguageFilePath.bangla
        : LanguageFilePath.english;

    await MultiLanguage.resetLanguage(
        path: languageFilePath, context: context);

    this.invokeChanges();
  }

  Future<LanguageChangeViewModel> initializeLanguage(
      BuildContext context) async {
    await MultiLanguage.initializeLanguage(
        path: LanguageFilePath.english,
        context: context,
       );

    LanguageChangeViewModel model = LanguageChangeViewModel();

    var langName = await getLanguageName();

    var isBanglaCurrentLanguage =
        LanguageNames.bangla.name == langName ? true : false;

    model.switchValue = isBanglaCurrentLanguage;

    return model;
  }

  
  Future<String> getLanguageName() async {
    String langguageFilePathKey = 'languageFilePath';

    final perfs = await SharedPreferences.getInstance();

    var langFilePath = perfs.getString(langguageFilePathKey);

    var langName = getLanguageNameFromFilePath(langFilePath);

    return langName.toUpperCase();

    // return langFilePath;
  }

  String getLanguageNameFromFilePath(String langFilePath) {

    
    var fileName = langFilePath.split("/").last;

    var langName = fileName.split('.').first;

    return langName;
  }
}
