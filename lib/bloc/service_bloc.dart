import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/model/service_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';

class ServiceBloc extends BaseBloc {
  final BehaviorSubject<ServiceModel> serviceDetail = new BehaviorSubject();

  void initData(String salonId, String categoryId) async {
    try {
      assert(salonId != null && salonId.isNotEmpty);
      var response;
      if (categoryId != null && categoryId.isNotEmpty)
        response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.service + salonId + "?category=" + categoryId);
      else
        response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.service + salonId);

      if (NetworkUtils.isReqSuccess(tag: ApiEndpoint.salonDetail, response: response)) {
        //SalonDetailModel model =
        //  SalonDetailModel.fromJson(json.decode(response.body));
        // serviceDetail.sink.add(model);
        ServiceModel model=ServiceModel.fromJson(json.decode(response.body));
        serviceDetail.sink.add(model);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    serviceDetail.close();
  }
}
