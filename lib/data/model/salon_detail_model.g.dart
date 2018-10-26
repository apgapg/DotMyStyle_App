// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonDetailModel _$SalonDetailModelFromJson(Map<String, dynamic> json) {
  return SalonDetailModel(
      json['id'] as String,
      json['name'] as String,
      json['address'] as String,
      json['image'] as String,
      (json['categories'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SalonDetailModelToJson(SalonDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'image': instance.image,
      'categories': instance.categories
    };

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) {
  return CategoryItem(json['id'] as String, json['category'] as String);
}

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{'id': instance.id, 'category': instance.category};
