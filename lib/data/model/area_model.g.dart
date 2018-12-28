// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaItem _$AreaItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'location']);
  return AreaItem(json['id'] as String, json['location'] as String);
}

Map<String, dynamic> _$AreaItemToJson(AreaItem instance) => <String, dynamic>{'id': instance.id, 'location': instance.location};
