import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/bloc/base_bloc.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/feed_model.dart';
import 'package:salon/network_utils.dart';

class ProfileBloc extends BaseBloc {
  BehaviorSubject<List<FeedItem>> profileController;

  ProfileBloc() {
    profileController = new BehaviorSubject();
    initData();
  }

  void initData() async {
    try {
    /*  var response = await apiHelper.getWithAuth(endpoint: ApiEndpoint.feeds);
      if (NetworkUtils.isReqSuccess(tag: ApiEndpoint.feeds, response: response)) {
        print(response.body);

        FeedModel feedModel = FeedModel.fromJson(json.decode(response.body));
        profileController.add(feedModel.feedList);
      } else {
        print("Some error");
      }*/
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    profileController.close();
  }
}
