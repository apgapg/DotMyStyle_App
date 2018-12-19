import 'package:flutter/material.dart';
import 'package:salon/api_helper.dart';

class Injector extends InheritedWidget {
  final ApiHelper apiHelper = new ApiHelper();

  Injector({
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  static Injector of(BuildContext context) => context.inheritFromWidgetOfExactType(Injector);

  @override
  bool updateShouldNotify(Injector oldWidget) => false;

  ApiHelper getApiHelper() {
    return apiHelper;
  }
}
