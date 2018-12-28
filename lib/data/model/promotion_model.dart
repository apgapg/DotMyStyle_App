import 'package:json_annotation/json_annotation.dart';

part 'promotion_model.g.dart';

class PromotionModel {
  List<PromotionItem> list;

  PromotionModel._internal(this.list);

  factory PromotionModel.fromJson(dynamic json) {
    return PromotionModel.fromMapList(list: json as List);
  }

  factory PromotionModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return PromotionItem.fromJson(item);
    }).toList();

    return PromotionModel._internal(items);
  }
}

@JsonSerializable()
class PromotionItem {
  final String id;
    @JsonKey(name: "image")

  final String promotion_image;
  
  PromotionItem(this.id,this.promotion_image);

  factory PromotionItem.fromJson(Map<String, dynamic> json) => _$PromotionItemFromJson(json);
}
