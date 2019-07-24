import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:salon/data/local/SharedPrefsHelper.dart';

ApiHelper apiHelper = new ApiHelper();

class ApiHelper {
  // static const baseUrl = "https://dotmystyle.com/api/v1/";
  static const baseUrl = "https://dotmystyle.herokuapp.com/api/v1/";

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

  Future<http.Response> getWithAuth({String endpoint}) async {
    return await http.get(baseUrl + endpoint, headers: getAuthTokenHeader());
  }

  Future<NetworkResponse> getWithAuth1({String endpoint}) async {
    var _raw =
    await http.get(baseUrl + endpoint, headers: getAuthTokenHeader());
    return parseResponse(_raw);
  }

  Map<String, String> getAuthTokenHeader() {
    Map<String, String> _map = new Map();
    _map.putIfAbsent("Authorization", () => "Bearer " + prefsHelper.token);
    return _map;
  }

  NetworkResponse parseResponse(http.Response response) {
    print("NetworkReq URL: " + response.request.url.toString());
    print("NetworkReq STATUS: " + response.statusCode.toString());
    print("NetworkReq BODY: " + response.body.toString());
    return NetworkResponse(response);
  }

  void getLocationData() {}
}

class NetworkResponse {
  http.Response response;
  int statusCode;
  bool isSuccess;
  String message;

  NetworkResponse(this.response) {
    this.statusCode = response.statusCode;
    this.message = response.body;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      this.isSuccess = false;
    } else
      this.isSuccess = true;
  }
}
