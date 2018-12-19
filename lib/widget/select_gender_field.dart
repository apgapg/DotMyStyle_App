import 'package:flutter/material.dart';

class SelectGenderField extends StatefulWidget {
  final ISelectGender gender;

  SelectGenderField(this.gender);

  @override
  SelectGenderFieldState createState() {
    return new SelectGenderFieldState();
  }
}

class SelectGenderFieldState extends State<SelectGenderField> {
  final List<String> _list = ["Male", "Female"];

  @override
  void initState() {
    super.initState();
    widget.gender.setGenderValue(_list[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormField(
        builder: (context) {
          return Row(
            children: <Widget>[
              Container(width: 100.0, child: RadioListTile<String>(title: Icon(Icons.person), value: _list[0], groupValue: widget.gender.getGenderValue(), onChanged: _onChange)),
              Container(width: 100.0, child: RadioListTile<String>(title: Icon(Icons.person_add), value: _list[1], groupValue: widget.gender.getGenderValue(), onChanged: _onChange)),
            ],
          );
        },
      ),
    );
  }

  void _onChange(String value) {
    setState(() {
      widget.gender.setGenderValue(value);
    });
  }
}

abstract class ISelectGender {
  String getGenderValue();

  void setGenderValue(String value);
}
