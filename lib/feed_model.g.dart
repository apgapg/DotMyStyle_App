// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedItem _$FeedItemFromJson(Map<String, dynamic> json) {
  return FeedItem(
      json['id'] as String,
      json['description'] as String,
      json['image'] as String,
      (json['tags'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$FeedItemToJson(FeedItem instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'image': instance.feed_url,
      'tags': instance.tags
    };
