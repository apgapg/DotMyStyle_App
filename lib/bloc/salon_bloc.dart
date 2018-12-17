import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/network_utils.dart';

class SalonBloc extends BaseBloc {
  static SalonBloc _instance = SalonBloc();
  BehaviorSubject<List<SalonItem>> salonList;
  BehaviorSubject<List<PromotionItem>> promotionList;

  factory SalonBloc() {
    if (_instance == null) return _instance = SalonBloc._internal();
    return _instance;
  }

  SalonBloc._internal() {
    salonList = new BehaviorSubject();
    promotionList = new BehaviorSubject();
    initPromotionData();
    initSalonData();
  }

  void initSalonData() async {
    try {
      var response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.salon);
      if (NetworkUtils.isReqSuccess(tag: ApiEndpoint.salon, response: response)) {
        print(response.body);

        var model = SalonModel.fromJson(json.decode(response.body));
        salonList.add(model.salonList);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }

  void initPromotionData() async {
    try {
      var response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.promotion);
      if (NetworkUtils.isReqSuccess(tag: ApiEndpoint.promotion, response: response)) {
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

  @override
  void dispose() {
    salonList.close();
    promotionList.close();
  }
}
