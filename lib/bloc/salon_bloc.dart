import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';

class SalonBloc {
  final BehaviorSubject<List<SalonItem>> salonList = new BehaviorSubject();
  final BehaviorSubject<List<PromotionItem>> promotionList = new BehaviorSubject();

  void initData() async {
    try {
      var response = await apiHelper.getWithAuth(url: ApiEndpoint.salon);
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.salon, response: response)) {
        print(response.body);

        var model = SalonModel.fromJson(json.decode(response.body));
        salonList.add(model.salonList);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
     try {
      var response = await apiHelper.getWithAuth(url: ApiEndpoint.promotion);
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.promotion, response: response)) {
        print(response.body);

         var model = PromotionModel.fromJson(json.decode(response.body));
        promotionList.add(model.promotionList);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }
}
