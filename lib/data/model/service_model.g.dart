// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceItem _$ServiceItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id', 'name', 'price', 'salon', 'category'],
      disallowNullValues: const ['id', 'name', 'price', 'salon', 'category']);
  return ServiceItem(
      json['id'] as String,
      json['name'] as String,
      json['price'] as int,
      json['salon'] as String,
      json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ServiceItemToJson(ServiceItem instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('price', instance.price);
  writeNotNull('salon', instance.salon);
  writeNotNull('category', instance.categoryItem);
  return val;
}
