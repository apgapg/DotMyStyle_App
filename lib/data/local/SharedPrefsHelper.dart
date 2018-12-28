import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

SharedPrefsHelper prefsHelper = new SharedPrefsHelper();

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  SharedPreferences _prefs;

  final String PREFS_TOKEN = "TOKEN";
  final String PREFS_IS_LOGIN = "ISLOGIN";

  final String PREFS_SELECTED_AREA_ID = "selectedareaid";
  final String PREFS_SELECTED_AREA_NAME = "selectedareaname";

  set selectedAreaId(value) => _prefs.setString(PREFS_SELECTED_AREA_ID, value);

  get selectedAreaId => _prefs.getString(PREFS_SELECTED_AREA_ID);

  set selectedAreaName(value) => _prefs.setString(PREFS_SELECTED_AREA_NAME, value);

  get selectedAreaName => _prefs.getString(PREFS_SELECTED_AREA_NAME);

  set token(value) => _prefs.setString(PREFS_TOKEN, value);

  get token => _prefs.getString(PREFS_TOKEN);

  set isLogin(value) => _prefs.setBool(PREFS_IS_LOGIN, value);

  get isLogin => _prefs.getBool(PREFS_IS_LOGIN) ?? false;

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return 0;
  }

  void checkIsInitialize() {
    assert(_prefs != null, "Call prefsHelper.initialize first before using Shared Prefs");
  }

  void clear() {
    _prefs.clear();
  }
}
