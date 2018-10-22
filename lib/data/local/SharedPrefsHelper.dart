import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

SharedPrefsHelper prefsHelper = new SharedPrefsHelper();

class SharedPrefsHelper {
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  SharedPreferences _prefs;

  final String PREFS_SESSION_ID = "SessionId";
  final String PREFS_TOKEN = "TOKEN";
  final String PREFS_IMAGES = "images";
  final String PREFS_IS_BEAT_SELECTED = "IsBeatSelected";
  final String PREFS_IS_LOGIN = "LOGIN";

  final String PREFS_IS_DAY_STARTED = "STARTED";

  final String PREFS_NAME = "NAME";

  final String PREFS_BEAT = "SelectedBeat";

  String PREFS_NON_WORKING_LIST = "nonworkinglist";
  String PREFS_SESSION_DATE = "sessionDate";

  String PREFS_MARKED_LEAVE = "markedLeave";

  String PREFS_USER_RANK = "userRank";

  String CONFIG_COMPANY_NAME = "config_companyName";

  String CONFIG_SHOW_BEATS = "config_showBeats";

  String PREFS_TEMP_MSQID = "tempmsqId";
  String PREFS_TEMP_HEADEND_TITLE = "tempheadend";

  String PREFS_PREFILLED_DATA = "prefilleddata";

  String PREFS_PLANNER_FILLED = "plannerfilled";

  String PREFS_PLANNING_MODEL = "planningModel";

  String PREFS_PLANNER_DOCUMENT_ID = "planningDocumentId";

  static const String PREFS_PREFILL_BEAT = "internal_beat";
  static const String PREFS_PREFILL_MSO = "internal_mso";
  static const String PREFS_PREFILL_PHASE = "internal_phase";
  static const String PREFS_PREFILL_AUDIT_DATE = "internal_audit_date";

  static const String PREFS_CLIENT_SELECTED = "debugclientselected";
  static const String PREFS_SELECTED_CLIENT = "debugselectedclient";

  static const String PREFS_TEMP_LCO_NAME_LIST = "templcoNameList";

  set selectedClient(value) => _prefs.setInt(PREFS_SELECTED_CLIENT, value);

  get selectedClient => _prefs.getInt(PREFS_SELECTED_CLIENT);

  set isClientSelected(value) => _prefs.setBool(PREFS_CLIENT_SELECTED, value);

  get isClientSelected => _prefs.getBool(PREFS_CLIENT_SELECTED) ?? false;

  set plannerFilled(value) => _prefs.setBool(PREFS_PLANNER_FILLED, value);

  get plannerFilled => _prefs.getBool(PREFS_PLANNER_FILLED) ?? false;

  //Company Identifier
  set config_companyName(value) => _prefs.setString(CONFIG_COMPANY_NAME, value);

  get config_companyName => _prefs.getString(CONFIG_COMPANY_NAME);

  set config_showBeats(value) => _prefs.setBool(CONFIG_SHOW_BEATS, value);

  get config_showBeats => _prefs.getBool(CONFIG_SHOW_BEATS);

  //
  set lcoNameList(value) => _prefs.setStringList(PREFS_TEMP_LCO_NAME_LIST, value);

  List<String> get lcoNameList => _prefs.getStringList(PREFS_TEMP_LCO_NAME_LIST);

  set phase(value) => _prefs.setString(PREFS_PREFILL_PHASE, value);

  get phase => _prefs.getString(PREFS_PREFILL_PHASE);

  set list_MSO(value) => _prefs.setStringList(PREFS_PREFILL_MSO, value);

  set userRank(value) => _prefs.setInt(PREFS_USER_RANK, value);

  get userRank => _prefs.getInt(PREFS_USER_RANK) ?? 0;

  set markedLeave(value) => _prefs.setBool(PREFS_MARKED_LEAVE, value);

  get markedLeave => _prefs.getBool(PREFS_MARKED_LEAVE) ?? false;

  set nonWorkingActivities(list) => _prefs.setStringList(PREFS_NON_WORKING_LIST, list);

  List<String> get nonWorkingActivities => _prefs.getStringList(PREFS_NON_WORKING_LIST);

  set sessionDay(value) => _prefs.setInt(PREFS_SESSION_DATE, value);

  int get sessionDay => _prefs.getInt(PREFS_SESSION_DATE);

  factory SharedPrefsHelper() {
    return _instance;
  }

  SharedPrefsHelper._internal();

  set sessionId(value) => _prefs.setString(PREFS_SESSION_ID, value);

  String get sessionId => _prefs.getString(PREFS_SESSION_ID);

  String get token => _prefs.getString(PREFS_TOKEN);

  String get images => _prefs.getString(PREFS_IMAGES);

  get isBeatSelected => _prefs.getBool(PREFS_IS_BEAT_SELECTED) ?? false;

  set isBeatSelected(value) => _prefs.setBool(PREFS_IS_BEAT_SELECTED, value);

  bool get isLogin => _prefs.getBool(PREFS_IS_LOGIN) ?? false;

  bool get isDayStarted => _prefs.getBool(PREFS_IS_DAY_STARTED) ?? false;

  set isDayStarted(value) => _prefs.setBool(PREFS_IS_DAY_STARTED, value);

  String get name => _prefs.getString(PREFS_NAME);

  String get beat => _prefs.getString(PREFS_BEAT);

  set beat(value) => _prefs.setString(PREFS_BEAT, value);

  /*set msqId(value) => _prefs.setString(PREFS_TEMP_MSQID, value);

  String get msqId => _prefs.getString(PREFS_TEMP_MSQID) ?? "Fill Details";

  set headendName(value) => _prefs.setString(PREFS_TEMP_HEADEND_TITLE, value);

  get headendName => _prefs.getString(PREFS_TEMP_HEADEND_TITLE);
*/
  set planningModel(value) => _prefs.setString(PREFS_PLANNING_MODEL, value);

  get planningModel => _prefs.getString(PREFS_PLANNING_MODEL);

  set plannerDocumentId(value) => _prefs.setString(PREFS_PLANNER_DOCUMENT_ID, value);

  get plannerDocumentId => _prefs.getString(PREFS_PLANNER_DOCUMENT_ID);

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return 0;
  }

  void checkIsInitialize() {
    assert(_prefs != null, "Call prefsHelper.initialize first before using Shared Prefs");
  }

  void setprefilledData(String headendName, Map<String, dynamic> filledQa) {
    _prefs.setString(headendName, json.encode(filledQa));
  }

  String getprefilledData(String headendName) {
    return _prefs.getString(headendName);
  }

  List<String> getStringList(String prefs_mso) {
    return _prefs.getStringList(prefs_mso);
  }

  void clear() {
    _prefs.clear();
  }
}
