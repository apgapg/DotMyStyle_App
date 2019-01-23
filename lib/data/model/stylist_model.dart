import 'package:json_annotation/json_annotation.dart';

part 'stylist_model.g.dart';

class StylistModel {
  List<StylistItem> stylistList;

  StylistModel._internal(this.stylistList);

  factory StylistModel.fromJson(dynamic json) {
    return StylistModel.fromMapList(list: json as List);
  }

  factory StylistModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return StylistItem.fromJson(item);
    }).toList();

    return StylistModel._internal(items);
  }
}

@JsonSerializable()
class StylistItem {
  final String id;
  final String name;
  final String about;
  @JsonKey(defaultValue: "Unisex", name: "gender_type")
  final String genderType;
  final String tagline;
  @JsonKey(name: "profile_picture")
  final String profilePicture;
  final String phone;

  StylistItem(this.id, this.name, this.about, this.genderType, this.tagline, this.profilePicture, this.phone);

  factory StylistItem.fromJson(Map<String, dynamic> json) => _$StylistItemFromJson(json);
}
