import 'package:flutter/material.dart';
import 'package:salon/bloc/base_bloc.dart';

class Provider<T extends BaseBloc> extends InheritedWidget {
  final T bloc;
  final Widget child;

  Provider({@required this.child, @required this.bloc});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static T of<T extends BaseBloc>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    Provider<T> provider = context.inheritFromWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}
