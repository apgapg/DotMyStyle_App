import 'package:json_annotation/json_annotation.dart';

part 'inspiraton_model.g.dart';

class InspirationModel {
  List<InspirationItem> list;

  InspirationModel._internal(this.list);

  factory InspirationModel.fromJson(dynamic json) {
    return InspirationModel.fromMapList(list: json as List);
  }

  factory InspirationModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return InspirationItem.fromJson(item);
    }).toList();

    return InspirationModel._internal(items);
  }
}

@JsonSerializable()
class InspirationItem {
  final String id;
  final String category;
  @JsonKey(name:"image")
  final String url;
  
  InspirationItem(this.id,this.category,this.url);

  factory InspirationItem.fromJson(Map<String, dynamic> json) => _$InspirationItemFromJson(json);
}
