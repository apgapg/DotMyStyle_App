import 'package:json_annotation/json_annotation.dart';

part 'stylist_detail_model.g.dart';

@JsonSerializable()
class StylistDetailModel {
  final String id;
  final String name;
  final String about;
  @JsonKey(name: "gender_type")
  final String genderType;
  final String tagline;
  @JsonKey(name: "profile_picture")
  final String profilePicture;
  @JsonKey(name: "offered_services")
  final List<OfferedServices> offeredServices;
  final Experience experience;
  final String phone;

  StylistDetailModel({this.id, this.name, this.about, this.genderType, this.tagline, this.profilePicture, this.offeredServices, this.experience, this.phone});

  factory StylistDetailModel.fromJson(Map<String, dynamic> json) => _$StylistDetailModelFromJson(json);
}

@JsonSerializable()
class OfferedServices {
  String category;
  List<Services> services;

  OfferedServices({this.category, this.services});

  factory OfferedServices.fromJson(Map<String, dynamic> json) => _$OfferedServicesFromJson(json);
}

@JsonSerializable()
class Services {
  final String sId;
  final String title;
  @JsonKey(name: "product_brand")
  final String productBrand;
  @JsonKey(name: "average_time")
  final String averageTime;
  final String category;
  final Pricing pricing;

  Services({this.sId, this.title, this.productBrand, this.averageTime, this.category, this.pricing});

  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);
}

@JsonSerializable()
class Pricing {
  @JsonKey(name: "base_price")
  final int basePrice;
  @JsonKey(name: "sale_price")
  final int salePrice;
  final int discount;
  @JsonKey(name: "is_dot_exclusive")
  final bool isDotExclusive;

  Pricing({this.basePrice, this.salePrice, this.discount, this.isDotExclusive});

  factory Pricing.fromJson(Map<String, dynamic> json) => _$PricingFromJson(json);
}

@JsonSerializable()
class Experience {
  @JsonKey(name: "year_experience", required: true, nullable: false)
  final int yearExperience;
  @JsonKey(name: "work_profile")
  final List<WorkProfile> workProfile;

  Experience({this.yearExperience, this.workProfile});

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);
}

@JsonSerializable()
class WorkProfile {
  final String title;
  final String image;

  WorkProfile({this.title, this.image});

  factory WorkProfile.fromJson(Map<String, dynamic> json) => _$WorkProfileFromJson(json);
}
