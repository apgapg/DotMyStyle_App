// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StylistDetailModel _$StylistDetailModelFromJson(Map<String, dynamic> json) {
  return StylistDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      about: json['about'] as String,
      genderType: json['gender_type'] as String,
      tagline: json['tagline'] as String,
      profilePicture: json['profile_picture'] as String,
      offeredServices: (json['offered_services'] as List)?.map((e) => e == null ? null : OfferedServices.fromJson(e as Map<String, dynamic>))?.toList(),
      experience: json['experience'] == null ? null : Experience.fromJson(json['experience'] as Map<String, dynamic>),
      phone: json['phone'] as String);
}

Map<String, dynamic> _$StylistDetailModelToJson(StylistDetailModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'about': instance.about,
      'gender_type': instance.genderType,
      'tagline': instance.tagline,
      'profile_picture': instance.profilePicture,
      'offered_services': instance.offeredServices,
      'experience': instance.experience,
      'phone': instance.phone
    };

OfferedServices _$OfferedServicesFromJson(Map<String, dynamic> json) {
  return OfferedServices(category: json['category'] as String, services: (json['services'] as List)?.map((e) => e == null ? null : Services.fromJson(e as Map<String, dynamic>))?.toList());
}

Map<String, dynamic> _$OfferedServicesToJson(OfferedServices instance) => <String, dynamic>{'category': instance.category, 'services': instance.services};

Services _$ServicesFromJson(Map<String, dynamic> json) {
  return Services(
      sId: json['sId'] as String,
      title: json['title'] as String,
      productBrand: json['product_brand'] as String,
      averageTime: json['average_time'] as String,
      category: json['category'] as String,
      pricing: json['pricing'] == null ? null : Pricing.fromJson(json['pricing'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'sId': instance.sId,
      'title': instance.title,
      'product_brand': instance.productBrand,
      'average_time': instance.averageTime,
      'category': instance.category,
      'pricing': instance.pricing
    };

Pricing _$PricingFromJson(Map<String, dynamic> json) {
  return Pricing(basePrice: json['base_price'] as int, salePrice: json['sale_price'] as int, discount: json['discount'] as int, isDotExclusive: json['is_dot_exclusive'] as bool);
}

Map<String, dynamic> _$PricingToJson(Pricing instance) =>
    <String, dynamic>{'base_price': instance.basePrice, 'sale_price': instance.salePrice, 'discount': instance.discount, 'is_dot_exclusive': instance.isDotExclusive};

Experience _$ExperienceFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['year_experience']);
  return Experience(
      yearExperience: json['year_experience'] as int, workProfile: (json['work_profile'] as List)?.map((e) => e == null ? null : WorkProfile.fromJson(e as Map<String, dynamic>))?.toList());
}

Map<String, dynamic> _$ExperienceToJson(Experience instance) => <String, dynamic>{'year_experience': instance.yearExperience, 'work_profile': instance.workProfile};

WorkProfile _$WorkProfileFromJson(Map<String, dynamic> json) {
  return WorkProfile(title: json['title'] as String, image: json['image'] as String);
}

Map<String, dynamic> _$WorkProfileToJson(WorkProfile instance) => <String, dynamic>{'title': instance.title, 'image': instance.image};
