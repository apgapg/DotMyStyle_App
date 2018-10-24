import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiHelper apiHelper = new ApiHelper();

class ApiHelper {
  static const baseUrl = "https://shielded-tor-73822.herokuapp.com/api/v1/";

  static final ApiHelper _instance = new ApiHelper._internal();

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal();


  Future<http.Response> getWithoutAuth(String url) async {
    return await http.get(baseUrl + url);
  }

  Future<http.Response> postWithoutAuth(String url, String body) async {
    Map<String, String> map = new Map();
    map.putIfAbsent("Content-Type", () => "application/json");
    return await http.post(baseUrl + url, body: body, headers: map);
  }

  Future<http.Response> getWithAuth({String url}) async {
    return await http.get(baseUrl + url, headers: getAuthTokenHeader());
  }

  Map<String, String> getAuthTokenHeader() {
    Map<String, String> _map = new Map();
    _map.putIfAbsent("Authorization", () =>  prefsHelper.token);
    return _map;
  }
}
