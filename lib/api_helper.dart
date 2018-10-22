import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiHelper apiHelper = new ApiHelper();

class ApiHelper {
  static final ApiHelper _instance = new ApiHelper._internal();

  factory ApiHelper() {
    return _instance;
  }

  ApiHelper._internal();

  Future<http.Response> getData() async {
    var response = await http.get("http://www.reweyou.in/test/tesd.php");
    return response;
  }

  // Future<http.Response> getWithAuth(String url) async {
  //   String auth = await getAuthToken();
  //   var result = await http.get(url, headers: {'Authorization': auth}).then((response) {
  //     return response;
  //   });
  //   return result;
  // }

  Future<http.Response> getWithoutAuth(String url) async {
    return await http.get(url);
  }

Future<http.Response> postWithoutAuth(String url,String body) async {
    return await http.post(url,body: body);
  }

  // Future<String> getAuthToken() async {
  //   return "Bearer " + prefsHelper.token;
  // }


}
