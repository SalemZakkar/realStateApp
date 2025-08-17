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
  propertyType: $enumDecode(
    _$RealEstatePropertyTypeEnumMap,
    json['property_type'],
  ),
  size: (json['property_size'] as num).toDouble(),
  room: (json['room'] as num).toInt(),
  bathrooms: (json['bathrooms'] as num).toInt(),
  propertyAge: (json['property_age'] as num).toInt(),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  isFavourite: json['isFavorite'] as bool? ?? false,
  description: json['description'] as String?,
  propertyDeedType: $enumDecode(
    _$RealEstatePropertyDeedTypeEnumMap,
    json['property_deed_type'],
  ),
  category: $enumDecode(_$RealEstateCategoryEnumMap, json['category']),
);

const _$RealEstatePropertyTypeEnumMap = {
  RealEstatePropertyType.apartment: 'apartment',
  RealEstatePropertyType.land: 'land',
  RealEstatePropertyType.villa: 'villa',
  RealEstatePropertyType.agriculturalLand: 'agricultural-land',
  RealEstatePropertyType.industrialLand: 'industrial-land',
  RealEstatePropertyType.farm: 'farm',
  RealEstatePropertyType.shop: 'shop',
  RealEstatePropertyType.architecture: 'architecture',
};

const _$RealEstatePropertyDeedTypeEnumMap = {
  RealEstatePropertyDeedType.green: 'green',
  RealEstatePropertyDeedType.courtRolling: 'courtRolling',
  RealEstatePropertyDeedType.municipal: 'municipal',
  RealEstatePropertyDeedType.farm: 'farm',
  RealEstatePropertyDeedType.industrial: 'industrial',
  RealEstatePropertyDeedType.agricultural: 'agricultural',
};

const _$RealEstateCategoryEnumMap = {
  RealEstateCategory.buy: 'buy',
  RealEstateCategory.rent: 'rent',
};
