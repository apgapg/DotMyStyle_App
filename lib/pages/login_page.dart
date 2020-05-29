import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:salon/api_helper.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';
import 'package:salon/utils/dialog_utils.dart';
import 'package:salon/utils/snackbar_utils.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  static const platform =
      const MethodChannel("workflowapp.flutter.io/devicedetail");

  TextEditingController _numberController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();

  bool _registerButtonEnabled = false;
  bool _otpButtonEnabled = false;

  String _sessionId;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showNumberPage = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      body: Container(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 48.0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  height: 90.0,
                ),
                new SizedBox(
                  height: 48.0,
                ),
                (!showNumberPage ? numberPage() : otpPage()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onRegisterButtonClick() async {
    await _initOtpReader();

    DialogUtils.showProgressBar(context, "Requesting OTP...");

    var number = _numberController.text;
    assert(number.length == 10);
    Map<String, String> map = new Map();
    map.putIfAbsent("number", () => number);
    var response =
        await apiHelper.postWithoutAuth(ApiEndpoint.sendOtp, jsonEncode(map));
    if (NetworkUtils.isReqSuccess(tag: "sendOtp", response: response)) {
      Navigator.pop(context);

      _sessionId = json.decode(response.body)['Details'];
      assert(_sessionId != null && _sessionId.isNotEmpty);
      setState(() {
        showNumberPage = !showNumberPage;
      });
    } else {
      Navigator.pop(context);
      SnackbarUtils.show(
          _scaffoldKey, "Something went wrong. Please try again");
//_scaffoldKey.currentState.showSnackBar(snackbar)
    }
  }

  onOtpButtonClick() async {
    DialogUtils.showProgressBar(context, "Please Wait!");
    String otp = _otpController.text.trim();
    assert(otp.length == 6);

    Map<String, String> _map = new Map();
// {
//   "device_name": "string",
//   "otp_input": "string",
//   "phone": "string",
//   "session_id": "string"
// }
//TODO: remove this hardcode
    assert(_sessionId != null);
    assert(_otpController.text != null);
    assert(_numberController.text != null);

    _map.putIfAbsent("device_name", () => "Ayush_phone");
    _map.putIfAbsent("otp_input", () => _otpController.text.trim());
    _map.putIfAbsent("phone", () => _numberController.text.trim());
    _map.putIfAbsent("session_id", () => _sessionId);

    print(json.encode(_map));
    http.Response response = await apiHelper.postWithoutAuth(
        ApiEndpoint.verifyOtp, json.encode(_map));
    if (NetworkUtils.isReqSuccess(
      tag: "verifyOtp",
      response: response,
    )) {
      print(response.headers);
      String token = jsonDecode(response.body)["token"];
      assert(token != null && token.isNotEmpty);
      prefsHelper.isLogin = true;
      prefsHelper.token = token;
      Navigator.pop(context);
      await Future.delayed(
        Duration(milliseconds: 200),
      );

      SnackbarUtils.show(_scaffoldKey, "Login Successful");
      await Future.delayed(
        Duration(milliseconds: 700),
      );
      // Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => new AreaPage()));
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pop(context);

      SnackbarUtils.show(_scaffoldKey, "Invalid OTP. Please try again");
//_scaffoldKey.currentState.showSnackBar(snackbar)
    }
  }

  Widget numberPage() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 8.0,
        ),
        new TextField(
          controller: _numberController,
          onChanged: (text) {
            var _number = text;
            if (_number.trim().length == 10) {
              setState(() {
                _registerButtonEnabled = true;
              });
            } else {
              setState(() {
                _registerButtonEnabled = false;
              });
            }
          },
          keyboardType: TextInputType.phone,
          style: new TextStyle(color: Colors.black87, fontSize: 18.0),
          decoration: new InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(2.0),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  right: 4.0,
                ),
                child: new Icon(Icons.phone),
              ),
              suffixStyle: TextStyle(color: Colors.grey[500], fontSize: 16.0),
              counterText: "",
              hintText: "Enter your number"),
          obscureText: false,
          maxLength: 10,
        ),
        new SizedBox(
          height: 24.0,
        ),
        new RaisedButton(
          elevation: 2.0,
          disabledTextColor: Colors.grey[700],
          disabledColor: Colors.grey[300],
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          textColor: Colors.white.withOpacity(0.9),
          onPressed: _registerButtonEnabled ? onRegisterButtonClick : null,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.power_settings_new,
                  color: _registerButtonEnabled
                      ? Colors.white.withOpacity(0.9)
                      : Colors.grey[700],
                  size: 20.0,
                ),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  "Register",
                  style: new TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        new SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Widget otpPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: new TextField(
            controller: _otpController,
            onChanged: (text) {
              var _otp = text;
              if (_otp.trim().length == 6) {
                setState(() {
                  _otpButtonEnabled = true;
                });
              } else {
                setState(() {
                  _otpButtonEnabled = false;
                });
              }
            },
            keyboardType: TextInputType.phone,
            style: new TextStyle(color: Colors.black87, fontSize: 18.0),
            decoration: new InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(2.0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: 4.0,
                    right: 4.0,
                  ),
                  child: new Icon(Icons.phone),
                ),
                suffixStyle: TextStyle(color: Colors.grey[500], fontSize: 16.0),
                counterText: "",
                hintText: "Enter OTP"),
            obscureText: false,
            maxLength: 6,
          ),
        ),
        new SizedBox(
          height: 24.0,
        ),
        new RaisedButton(
          elevation: 2.0,
          disabledTextColor: Colors.grey[700],
          disabledColor: Colors.grey[300],
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          textColor: Colors.white.withOpacity(0.9),
          onPressed: _otpButtonEnabled ? onOtpButtonClick : null,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            child: Text(
              "Submit",
              style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        new SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Future<void> _initOtpReader() async {
    if (Platform.isAndroid) {
      final bool result = await platform.invokeMethod('smsPermission');
      if (result != null && result) {
        print("SMS Permission granted");
        platform.invokeMethod('getOtp').then((otp) {
          print(otp.toString());
          if (otp != null && otp.toString().isNotEmpty) {
            _otpController.text = otp.toString();
            onOtpButtonClick();
          }
        });
      } else {
        print("Otp init error");
      }
    }
  }
}
