import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///This utility package is inspired by : https://pub.dev/packages/multilanguage
/// GitHub : https://github.com/misaelriojasm/Multilanguage
/// I have made some modifications to this package and that's why instead of getting it from pub; I am using the updated source code directly in my project.

/// THE NAME OF CURRENT JSON FILE INSIDE THE APP CACHE
String _languageFilePathKey = 'languageFilePath';

/// THE NAME OF THE CLASS WHICH MANAGES THE MULTI-LANGUAGE PACKAGE
class MultiLanguage {
  Map<String, dynamic> keyValueTexts;
  MultiLanguage(this.keyValueTexts);

  ///Resetting the language on the fly by user.
  ///It directly updates the languageFilePathKey value inside shared preference with choosen language file
  ///It normally happens when user wants to choose their preferred language runtime.
  static resetLanguage(
      {@required String path,
    
      @required BuildContext context}) async {
    /// GETS THE SHARE PREFERENCES INSTANCE
    final prefs = await SharedPreferences.getInstance();

    /// LOAD LANGUAGE FILE AND PARSE IT INTO A MAP
    await _loadLanguageFIle(context, path, prefs);
  }

  /// SET THE LANGUAGE METHOD
  /// USES PATH FROM [LANGUAGES] TO GET THE FILE
  /// USES CONTEXT TO GET THE FULL PATH
  /// WHEN LANGUAGE FILE WAS PREVIOUSLY LOADED; IT
  static initializeLanguage(
      {@required String path,
    
      @required BuildContext context}) async {
    /// GETS THE SHARE PREFERENCES INSTANCE
    final prefs = await SharedPreferences.getInstance();

    /// VALIDATES IF THE PATH EXIST INSIDE THE PHONE
    /// WHEN FILEPATH IS ALREADY SET; IT WILL TAKE THAT FILE PATH INSTEAD OF FILE PATH PROVIDED TO BE SET.
    /// THIS WAY WE CAN PRESERVE THE LAST CHOOSEN LANGUAGE BY USER.
    /// NORMALLY; THIS FUNCTION WILL BE CALLED ONLY ONCE DURING THE INITIALIZATION OF THE APP.
    /// IF YOU WANT TO RESET THE LANGUAGE; CALL resetLanguage METHOD. IT OVERWRITES THE EXISTING FILE PATH VALUE.
    if (prefs.getString(_languageFilePathKey) != null) {
      path = prefs.getString(_languageFilePathKey);
    }

    /// LOAD LANGUAGE FILE AND PARSE IT INTO A MAP
    await _loadLanguageFIle(context, path,  prefs);
  }

  static Future _loadLanguageFIle(BuildContext context, String path,
       SharedPreferences prefs) async {
    /// GETS THE FILE PATH
    var file = await DefaultAssetBundle.of(context).loadString(path);

    /// SETS THE FILE PATH INSIDE THE PHONE
    var canSetLangFilePath = await prefs.setString(_languageFilePathKey, path);

    /// LOADS THE JSON FILE INSIDE THE MULTILANG
    multilang = MultiLanguage(jsonDecode(file));
  }

  /// GET METHOD RETURNS THE STRING FROM THE JSON FILE CREATED
  String get(String key) {
    /// IF STRING DON'T EXIST JUST RETURNS THE NAME OF THE STRING YOU WANTED TO SEARCH
    return keyValueTexts != null ? keyValueTexts[key] : key;
  }
}

/// INITIALIZE THE MULTILANG - YOU WILL BE USING THIS AROUND YOUR APPLICATION
MultiLanguage multilang = MultiLanguage(null);

/// SHORTCUT FOR THE GETTER TEXT
Function(String key) get getLanguageText => multilang.get;

/// SHORTCUT FOR THE GETTER UPPERCASE TEXT
Function(String key) get uptxt =>
    (String key) => multilang.get(key).toUpperCase();
