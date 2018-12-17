import 'package:flutter/material.dart';

class GenderLabel extends StatelessWidget {
  final String genderType;

  GenderLabel(this.genderType);

  @override
  Widget build(BuildContext context) {
    assert(genderType != null && genderType.isNotEmpty);
    return Container(
      height: 28.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Text(genderType),
    );
  }
}
