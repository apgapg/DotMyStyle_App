import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/feed_model.dart';

class FeedBloc extends BaseBloc {
  BehaviorSubject<List<FeedItem>> feedController;

  FeedBloc() {
    feedController = new BehaviorSubject();
    initData();
  }

  void initData() async {
    NetworkResponse _networkResponse = await apiHelper.getWithAuth1(endpoint: ApiEndpoint.feeds);
    if (_networkResponse.isSuccess) {
      FeedModel feedModel = FeedModel.fromJson(json.decode(_networkResponse.response.body));
      feedController.add(feedModel.feedList);
    } else {
      print("Some error");
    }
  }

  @override
  void dispose() {
    feedController.close();
  }
}
