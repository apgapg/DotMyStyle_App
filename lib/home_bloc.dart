import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:salon/api_helper.dart';
import 'package:salon/network_utils.dart';
import 'package:salon/notification_model.dart';

class NotificationBloc {
  final BehaviorSubject<List<NotificationItem>> dataList = new BehaviorSubject();

  void initData() async {
    try {
      var response = await ApiHelper().getData();
      if (NetworkUtils.isReqSuccess(tag: "Data", response: response)) {
        var notificationModel = NotificationModel.fromJson(json.decode(response.body));
        dataList.sink.add(notificationModel.notificationList);
      } else {
        getNotificationFromDatabase();
      }
    } catch (e) {
      print(e);
      getNotificationFromDatabase();
    }
  }

  void getNotificationFromDatabase() async {}
}
