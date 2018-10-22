// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) {
  return NotificationItem(json['shopname'] as String, json['address'] as String,
      json['ownername'] as String, json['rating'] as String);
}

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'shopname': instance.shopname,
      'address': instance.address,
      'ownername': instance.ownername,
      'rating': instance.rating
    };
