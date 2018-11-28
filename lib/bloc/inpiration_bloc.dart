import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/data/model/inspiraton_model.dart';

import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';

class InspirationBloc {
  final BehaviorSubject<List<InspirationItem>> list = new BehaviorSubject();

  void initData() async {
    try {
      var response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.inspiration);
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.inspiration, response: response)) {
        var model = InspirationModel.fromJson(json.decode(response.body));
        list.add(model.list);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }
}
