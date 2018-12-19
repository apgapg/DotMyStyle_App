import 'package:flutter/material.dart';
import 'package:salon/bloc/injector.dart';
import 'package:salon/bloc/location_bloc.dart';

class LocationPage extends StatefulWidget {
  @override
  LocationPageState createState() {
    return new LocationPageState();
  }
}

class LocationPageState extends State<LocationPage> {
  LocationBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = new LocationBloc(Injector.of(context).getApiHelper());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Location",
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        iconTheme: IconThemeData(
          color: Colors.blueGrey[700],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }
}
