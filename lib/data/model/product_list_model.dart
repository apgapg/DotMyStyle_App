import 'package:json_annotation/json_annotation.dart';
import 'package:salon/data/model/salon_detail_model.dart';

part 'product_list_model.g.dart';

class ProductListModel {
  List<ProductItem> list;

  ProductListModel._internal(this.list);

  factory ProductListModel.fromJson(dynamic json) {
    return ProductListModel.fromMapList(list: json as List);
  }

  factory ProductListModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return ProductItem.fromJson(item);
    }).toList();

    return ProductListModel._internal(items);
  }
}

@JsonSerializable()
class ProductItem {
  final String id;
  final String name;
  final String image;
  final String description;
  final CategoryModel categoryModel;

  ProductItem(this.id, this.name, this.image, this.description, this.categoryModel);

  factory ProductItem.fromJson(Map<String, dynamic> json) => _$ProductItemFromJson(json);
}
