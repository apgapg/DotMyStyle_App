// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonItem _$SalonItemFromJson(Map<String, dynamic> json) {
  return SalonItem(
      json['id'] as String,
      json['name'] as String,
      json['address'] as String,
      json['image'] as String,
      json['gender_type'] as String ?? 'Unisex',
      json['location'] as String);
}

Map<String, dynamic> _$SalonItemToJson(SalonItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'image': instance.image,
  'gender_type': instance.genderType,
  'location': instance.group
    };
