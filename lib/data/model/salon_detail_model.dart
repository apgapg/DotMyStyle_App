import 'package:json_annotation/json_annotation.dart';

part 'salon_detail_model.g.dart';

@JsonSerializable()
class SalonDetailModel {
  final String id;
  final String name;
  final String address;
  final String image;
  final List<CategoryItem> categories;

  SalonDetailModel(
      this.id, this.name, this.address, this.image, this.categories);

  factory SalonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SalonDetailModelFromJson(json);
}

@JsonSerializable()
class CategoryItem {
  final String id;
  final String category;

  CategoryItem(this.id, this.category);

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
