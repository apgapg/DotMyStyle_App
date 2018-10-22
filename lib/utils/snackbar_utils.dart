import 'package:flutter/material.dart';

class SnackbarUtils {
  static void show(GlobalKey<ScaffoldState> scaffoldKey,String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: Text(text),));
  }
}
