import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'notification_model.g.dart';

class NotificationModel {
  List<NotificationItem> notificationList;

  NotificationModel._internal(this.notificationList);

  factory NotificationModel.fromJson(dynamic json) {
    return NotificationModel.fromMapList(list: json as List);
  }

  factory NotificationModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return NotificationItem.fromJson(item);
    }).toList();

    return NotificationModel._internal(items);
  }
}

@JsonSerializable()
class NotificationItem {
  final String shopname;
  final String address;
  final String ownername;
  final String rating;
  NotificationItem(this.shopname, this.address, this.ownername, this.rating);

  factory NotificationItem.fromJson(Map<String, dynamic> json) => _$NotificationItemFromJson(json);
}
