import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/local/SharedPrefsHelper.dart';
import 'package:salon/data/model/category_model.dart';
import 'package:salon/data/model/promotion_model.dart';
import 'package:salon/data/model/salon_model.dart';
import 'package:salon/data/model/stylist_model.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/feed_model.dart';
import 'package:salon/network_utils.dart';

class SalonBloc extends BaseBloc {
  static SalonBloc _instance = SalonBloc._internal();
  BehaviorSubject<List<SalonItem>> salonPopularList;
  BehaviorSubject<List<SalonItem>> salonExtraList;
  BehaviorSubject<List<PromotionItem>> promotionList;
  BehaviorSubject<List<FeedItem>> feedController;
  BehaviorSubject<List<StylistItem>> stylistController;
  BehaviorSubject<List<CategoryItem>> categoryController;

  factory SalonBloc() {
    if (_instance == null) return _instance = SalonBloc._internal();
    return _instance;
  }

  SalonBloc._internal() {
    salonPopularList = new BehaviorSubject();
    salonExtraList = new BehaviorSubject();
    promotionList = new BehaviorSubject();
    feedController = new BehaviorSubject();
    stylistController = new BehaviorSubject();
    categoryController = new BehaviorSubject();

    initPromotionData();
    initSalonData();
    initFeedData();
    initStylistData();
    initCategoryData();
  }

  void initSalonData() async {
    try {
      var response = await apiHelper.getWithAuth(
          endpoint: ApiEndpoint.salon +
              "?location=" +
              prefsHelper.selectedAreaId.toString());
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.salon, response: response)) {
        print(response.body);

        var model = SalonModel.fromJson(json.decode(response.body));
        /*   String group = model.salonList
            .elementAt(0)
            .group;
        List<SalonItem> popular = model.salonList.where((item) => item.group == group).toList();
        List<SalonItem> extras = model.salonList.where((item) => item.group != group).toList();
*/
        salonPopularList.add(model.salonList);
        // salonExtraList.add(extras);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }

  void initPromotionData() async {
    try {
      var response =
      await apiHelper.getWithAuth(endpoint: ApiEndpoint.promotion);
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.promotion, response: response)) {
        print(response.body);

        var model = PromotionModel.fromJson(json.decode(response.body));
        promotionList.add(model.list);
      } else {
        print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }

  void initFeedData() async {
    NetworkResponse _networkResponse =
    await apiHelper.getWithAuth1(endpoint: ApiEndpoint.feeds);
    if (_networkResponse.isSuccess) {
      FeedModel feedModel =
      FeedModel.fromJson(json.decode(_networkResponse.response.body));
      feedController.add(feedModel.feedList);
    } else {
      print("Some error");
    }
  }

  void initStylistData() async {
    NetworkResponse _networkResponse =
    await apiHelper.getWithAuth1(endpoint: ApiEndpoint.experts);
    if (_networkResponse.isSuccess) {
      StylistModel _model =
      StylistModel.fromJson(json.decode(_networkResponse.response.body));
      stylistController.add(_model.stylistList);
    } else {
      print("Some error");
    }
  }

  void initCategoryData() async {
    NetworkResponse _networkResponse =
    await apiHelper.getWithAuth1(endpoint: ApiEndpoint.categoryList);
    if (_networkResponse.isSuccess) {
      CategoryModel _model =
      CategoryModel.fromJson(json.decode(_networkResponse.response.body));
      categoryController.add(_model.categoryList);
    } else {
      print("Some error");
    }
  }

  @override
  void dispose() {
    salonPopularList.close();
    salonExtraList.close();
    promotionList.close();
    feedController.close();
    stylistController.close();
    categoryController.close();
  }
}
