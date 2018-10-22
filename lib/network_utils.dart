import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class NetworkUtils {
  static isReqSuccess({@required String tag, @required http.Response response}) {
    print("Network Request: " + tag + ": " + "ResponseBody: " + response.body.toString());
    if (response.statusCode < 200 || response.statusCode >= 300) {
      print("Network Request: " + tag + ": " "ResponseErrorCode: " + response.statusCode.toString());
      return false;
    } else {
      return true;
    }
  }
}
