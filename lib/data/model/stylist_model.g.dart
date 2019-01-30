// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StylistItem _$StylistItemFromJson(Map<String, dynamic> json) {
  return StylistItem(
      json['id'] as String,
      json['name'] as String,
      json['about'] as String,
      json['gender_type'] as String ?? 'Unisex',
      json['tagline'] as String,
      json['profile_picture'] as String,
      json['phone'] as String);
}

Map<String, dynamic> _$StylistItemToJson(StylistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'about': instance.about,
      'gender_type': instance.genderType,
      'tagline': instance.tagline,
      'profile_picture': instance.profilePicture,
      'phone': instance.phone
    };
