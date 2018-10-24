import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/customWidget/custom_progress_indicator.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';
import 'package:salon/pages/home_page.dart';
import 'package:salon/utils/dialog_utils.dart';
import 'package:salon/utils/snackbar_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
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
      body: new Stack(
        children: <Widget>[
          Container(
            height: 300.0,
            color: Color(0xFFFFD600),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 32.0),
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        spreadRadius: 12.0,
                        blurRadius: 12.0,
                        color: Colors.black12)
                  ]),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /* new CircleAvatar(
                      radius: animation.value * 50.0,
                      child: new Icon(
                        Icons.live_tv,
                        size: animation.value * 40.0,
                      ),
                      backgroundColor: Colors.white,
                    ),*/
                  new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('assets/images/logo.jpg'),
                          fit: BoxFit.fitHeight),
                    ),
                    height: 80.0,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                  ),
                  new Text(
                    "Welcome to DOT",
                    style: new TextStyle(
                        fontSize: 22.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700),
                  ),
                  new SizedBox(
                    height: 48.0,
                  ),
                  (!showNumberPage ? numberPage() : otpPage()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onRegisterButtonClick() async {
    DialogUtils.showProgressBar(context, "Requesting OTP...");

    var number = _numberController.text;
    assert(number.length == 10);
    var response = await apiHelper.getWithoutAuth(ApiEndpoint.sendOtp + number);
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
      String token = response.headers['authorization'];
      assert(token != null && token.isNotEmpty);
      prefsHelper.isLogin=true;
      prefsHelper.token = token;
      Navigator.pop(context);
      SnackbarUtils.show(_scaffoldKey, "Login Successful");
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => new HomePage()));
    } else {
      Navigator.pop(context);

      SnackbarUtils.show(_scaffoldKey, "Invalid OTP. Please try again");
//_scaffoldKey.currentState.showSnackBar(snackbar)
    }
  }

  Widget numberPage() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: new TextField(
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
                hintText: "Enter your Number"),
            obscureText: false,
            maxLength: 10,
          ),
        ),
        new SizedBox(
          height: 24.0,
        ),
        new FlatButton(
          disabledTextColor: Colors.grey[500],
          textColor: _registerButtonEnabled ? Colors.blue : Colors.grey,
          onPressed: _registerButtonEnabled ? onRegisterButtonClick : null,
          child: new Text(
            "Register",
            style: new TextStyle(fontSize: 22.0),
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
            maxLength: 10,
          ),
        ),
        new SizedBox(
          height: 24.0,
        ),
        new FlatButton(
          disabledTextColor: Colors.grey[500],
          textColor: _registerButtonEnabled ? Colors.blue : Colors.grey,
          onPressed: _otpButtonEnabled ? onOtpButtonClick : null,
          child: new Text(
            "Submit",
            style: new TextStyle(fontSize: 22.0),
          ),
        ),
        new SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
