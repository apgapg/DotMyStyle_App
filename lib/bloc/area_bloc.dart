import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/model/area_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';

class AreaBloc extends BaseBloc {
  static AreaBloc _instance = AreaBloc._internal();
  BehaviorSubject<List<AreaItem>> areaController;

  factory AreaBloc() {
    if (_instance == null) return _instance = AreaBloc._internal();
    return _instance;
  }

  AreaBloc._internal() {
    areaController = new BehaviorSubject();
    initData();
  }

  void initData() async {
    try {
      var response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.area);
      if (NetworkUtils.isReqSuccess(tag: ApiEndpoint.promotion, response: response)) {
        print(response.body);
        var model = AreaModel.fromJson(json.decode(response.body));
        assert(model.list.isNotEmpty);
        areaController.add(model.list);
      } else {
        areaController.addError("Something went wrong. ErrorCode: " + response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      areaController.addError("Something went wrong.");
    }
  }

  @override
  void dispose() {
    areaController.close();
  }
}
