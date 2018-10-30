// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonDetailModel _$SalonDetailModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'name', 'address'],
      disallowNullValues: const ['id', 'name', 'address']);
  return SalonDetailModel(
      json['id'] as String,
      json['name'] as String,
      json['address'] as String,
      json['image'] as String,
      (json['categories'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SalonDetailModelToJson(SalonDetailModel instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('address', instance.address);
  val['image'] = instance.image;
  val['categories'] = instance.categories;
  return val;
}

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'category'],
      disallowNullValues: const ['id', 'category']);
  return CategoryModel(json['id'] as String, json['category'] as String);
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('category', instance.category);
  return val;
}
