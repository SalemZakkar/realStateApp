// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'real_estate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RealEstateModel _$RealEstateModelFromJson(Map json) => RealEstateModel(
  id: json['_id'] as String,
  title: json['title'] as String,
  price: (json['price'] as num).toDouble(),
  city: CityModel.fromJson(Map<String, dynamic>.from(json['city'] as Map)),
  neighborhood: json['neighborhood'] as String,
  address: json['address'] as String?,
  location: RealEstateLocationModel.fromJson(
    Map<String, dynamic>.from(json['location'] as Map),
  ),
  propertyType: $enumDecode(_$PropertyTypeEnumMap, json['property_type']),
  size: (json['property_size'] as num).toDouble(),
  room: (json['room'] as num).toInt(),
  bathrooms: (json['bathrooms'] as num).toInt(),
  propertyAge: (json['property_age'] as num).toInt(),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  isFavourite: json['isFavourite'] as bool? ?? false,
  description: json['description'] as String?,
);

const _$PropertyTypeEnumMap = {
  PropertyType.apartment: 'apartment',
  PropertyType.land: 'land',
  PropertyType.villa: 'villa',
  PropertyType.agriculturalLand: 'agricultural-land',
  PropertyType.industrialLand: 'industrial-land',
  PropertyType.farm: 'farm',
  PropertyType.shop: 'shop',
  PropertyType.architecture: 'architecture',
};
