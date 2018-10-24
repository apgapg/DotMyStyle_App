import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/data/network/api_endpoint.dart';
import 'package:salon/feed_model.dart';
import 'package:salon/network_utils.dart';

class HomeBloc {
  final BehaviorSubject<List<FeedItem>> feedList =
      new BehaviorSubject();

  void initData() async {
    try {
      var response = await apiHelper.getWithAuth(url: ApiEndpoint.feeds);
      if (NetworkUtils.isReqSuccess(
          tag: ApiEndpoint.feeds, response: response)) {
        print(response.body);

        FeedModel feedModel=FeedModel.fromJson(json.decode(response.body));
        feedList.add(feedModel.feedList);

      } else {
print("Some error");
      }
    } catch (e) {
      print(e);
    }
  }

}
