import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'feed_model.g.dart';

class FeedModel {
  List<FeedItem> feedList;

  FeedModel._internal(this.feedList);

  factory FeedModel.fromJson(dynamic json) {
    return FeedModel.fromMapList(list: json as List);
  }

  factory FeedModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return FeedItem.fromJson(item);
    }).toList();

    return FeedModel._internal(items);
  }
}

@JsonSerializable()
class FeedItem {
  final String id;
  final String description;
      @JsonKey(name: "image")

  final String feed_url;
  final List<String> tags;
  FeedItem(this.id,this.description,this.feed_url,this.tags);

  factory FeedItem.fromJson(Map<String, dynamic> json) => _$FeedItemFromJson(json);
}
