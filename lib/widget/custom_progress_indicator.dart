import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      strokeWidth: 0.5,
    );
  }
}
