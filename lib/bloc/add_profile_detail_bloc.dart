import 'package:flutter/material.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/widget/select_age_field.dart';
import 'package:salon/widget/select_gender_field.dart';

class AddProfileDetailBloc extends BaseBloc implements ISelectGender, ISelectAge {
  TextEditingController nameController;

  String genderValue;

  String ageValue;

  final formKey = new GlobalKey<FormState>();

  AddProfileDetailBloc() {
    nameController = new TextEditingController();
  }

  @override
  void dispose() {}

  @override
  String getGenderValue() {
    return this.genderValue;
  }

  @override
  void setGenderValue(String value) {
    this.genderValue = value;
  }

  @override
  String getAgeValue() {
    return this.ageValue;
  }

  @override
  void setAgeValue(String value) {
    this.ageValue = value;
  }

  void onSubmit() {
    if (formKey.currentState.validate()) {
      print(getGenderValue());
      print(getAgeValue());
    }
  }
}
