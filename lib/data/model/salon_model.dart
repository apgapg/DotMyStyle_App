import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'salon_model.g.dart';

class SalonModel {
  List<SalonItem> salonList;

  SalonModel._internal(this.salonList);

  factory SalonModel.fromJson(dynamic json) {
    return SalonModel.fromMapList(list: json as List);
  }

  factory SalonModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return SalonItem.fromJson(item);
    }).toList();

    return SalonModel._internal(items);
  }
}

@JsonSerializable()
class SalonItem {
  final String id;
  final String name;
  final String address;
  final String image;
  SalonItem(this.id,this.name,this.address,this.image);

  factory SalonItem.fromJson(Map<String, dynamic> json) => _$SalonItemFromJson(json);
}
