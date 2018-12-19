import 'package:flutter/material.dart';

class SelectAgeField extends StatefulWidget {
  final ISelectAge age;

  SelectAgeField(this.age);

  @override
  SelectAgeFieldState createState() {
    return new SelectAgeFieldState();
  }
}

class SelectAgeFieldState extends State<SelectAgeField> {
  final List<String> _list = ["0-20", "20-30", "30-40", "40+"];

  @override
  void initState() {
    super.initState();
    widget.age.setAgeValue(_list[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormField(
        builder: (context) {
          return Column(
              children: _list
                  .map((item) => RadioListTile<String>(
                        title: Text(item),
                        value: item,
                        groupValue: widget.age.getAgeValue(),
                        onChanged: _onChange,
                      ))
                  .toList());
        },
      ),
    );
  }

  void _onChange(String value) {
    setState(() {
      widget.age.setAgeValue(value);
    });
  }
}

abstract class ISelectAge {
  String getAgeValue();

  void setAgeValue(String value);
}
