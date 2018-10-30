import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:salon/data/model/salon_detail_model.dart';

part 'service_model.g.dart';

class ServiceModel {
  List<ServiceItem> list;

  ServiceModel._internal(this.list);

  factory ServiceModel.fromJson(dynamic json) {
    return ServiceModel.fromMapList(list: json as List);
  }

  factory ServiceModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return ServiceItem.fromJson(item);
    }).toList();

    return ServiceModel._internal(items);
  }
}

@JsonSerializable()
class ServiceItem {
  @JsonKey(required: true, disallowNullValue: true)
  final String id;
  @JsonKey(required: true, disallowNullValue: true)
  final String name;
  @JsonKey(required: true, disallowNullValue: true)
  final int price;
  @JsonKey(required: true, disallowNullValue: true)
  final String salon;
  @JsonKey(name: "category",required: true, disallowNullValue: true)
  final CategoryModel categoryItem;
  ServiceItem(this.id, this.name, this.price, this.salon, this.categoryItem);

  factory ServiceItem.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemFromJson(json);
}
