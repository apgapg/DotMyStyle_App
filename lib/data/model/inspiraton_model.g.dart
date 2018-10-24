// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspiraton_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspirationItem _$InspirationItemFromJson(Map<String, dynamic> json) {
  return InspirationItem(json['id'] as String, json['category'] as String,
      json['image'] as String);
}

Map<String, dynamic> _$InspirationItemToJson(InspirationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'image': instance.url
    };
