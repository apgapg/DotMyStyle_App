import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/model/salon_detail_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';

class SalonDetailBloc implements BaseBloc {
  final BehaviorSubject<SalonDetailModel> salonDetail = new BehaviorSubject();

  void initData(String id) async {
    try {
      var response =
          await apiHelper.getWithAuth(endpoint: ApiEndpoint.salonDetail + id);
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.salonDetail, response: response)) {
        SalonDetailModel model =
            SalonDetailModel.fromJson(json.decode(response.body));
        salonDetail.sink.add(model);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    salonDetail.close();
  }
}
