// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) {
  return ProductItem(
      json['id'] as String,
      json['name'] as String,
      json['image'] as String,
      json['description'] as String,
      json['categoryModel'] == null
          ? null
          : CategoryModel.fromJson(
              json['categoryModel'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'categoryModel': instance.categoryModel
    };
