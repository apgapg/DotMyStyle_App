import 'package:flutter/material.dart';
import 'package:salon/bloc/add_profile_detail_bloc.dart';
import 'package:salon/bloc/provider.dart';
import 'package:salon/widget/select_age_field.dart';
import 'package:salon/widget/select_gender_field.dart';

class AddProfileDetailPage extends StatefulWidget {
  @override
  _AddProfileDetailPageState createState() => _AddProfileDetailPageState();
}

class _AddProfileDetailPageState extends State<AddProfileDetailPage> {
  final AddProfileDetailBloc bloc = new AddProfileDetailBloc();

  @override
  Widget build(BuildContext context) {
    return Provider<AddProfileDetailBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Profile",
            style: TextStyle(color: Colors.blueGrey[700]),
          ),
          elevation: 2.0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: bloc.onSubmit,
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Form(
              key: bloc.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const HeaderWidget("Your Name"),
                  const SizedBox(
                    height: 8.0,
                  ),
                  NameField(bloc.nameController),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const HeaderWidget("Gender"),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SelectGenderField(bloc),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const HeaderWidget("Age"),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SelectAgeField(bloc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NameField extends StatelessWidget {
  final TextEditingController nameController;

  NameField(this.nameController);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Enter name",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        ),
        controller: nameController,
        validator: (text) {
          if (text.trim().length == 0) return "Please provide a valid name.";
        },
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  const HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black54),
      ),
    );
  }
}
