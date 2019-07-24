import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

class CategoryModel {
  List<CategoryItem> categoryList;

  CategoryModel._internal(this.categoryList);

  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel.fromMapList(list: json as List);
  }

  factory CategoryModel.fromMapList({List<dynamic> list}) {
    final items =
        list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return CategoryItem.fromJson(item);
    }).toList();

    return CategoryModel._internal(items);
  }
}

@JsonSerializable()
class CategoryItem {
  @JsonKey(name: "_id")
  final String id;
  final String image;
  final String category;

  CategoryItem(this.id, this.image, this.category);

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
