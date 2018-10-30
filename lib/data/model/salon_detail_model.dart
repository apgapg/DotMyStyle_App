import 'package:json_annotation/json_annotation.dart';

part 'salon_detail_model.g.dart';

@JsonSerializable()
class SalonDetailModel {
  @JsonKey(required: true,disallowNullValue: true)
  final String id;
  @JsonKey(required: true,disallowNullValue: true)
  final String name;
  @JsonKey(required: true,disallowNullValue: true)
  final String address;
  final String image;
  final List<CategoryModel> categories;

  SalonDetailModel(this.id, this.name, this.address, this.image, this.categories);

  factory SalonDetailModel.fromJson(Map<String, dynamic> json) => _$SalonDetailModelFromJson(json);
}

@JsonSerializable()
class CategoryModel {
  @JsonKey(required: true, disallowNullValue: true)
  final String id;
  @JsonKey(required: true, disallowNullValue: true)
  final String category;

  CategoryModel(this.id, this.category);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}
