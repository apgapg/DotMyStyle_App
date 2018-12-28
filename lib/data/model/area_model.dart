import 'package:json_annotation/json_annotation.dart';

part 'area_model.g.dart';

class AreaModel {
  List<AreaItem> list;

  AreaModel._internal(this.list);

  factory AreaModel.fromJson(dynamic json) {
    return AreaModel.fromMapList(list: json as List);
  }

  factory AreaModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return AreaItem.fromJson(item);
    }).toList();

    return AreaModel._internal(items);
  }
}

@JsonSerializable()
class AreaItem {
  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String location;

  AreaItem(this.id, this.location);

  factory AreaItem.fromJson(Map<String, dynamic> json) => _$AreaItemFromJson(json);
}
