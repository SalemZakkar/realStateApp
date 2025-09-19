// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'real_estate_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RealEstateParamsModelToJson(
  RealEstateParamsModel instance,
) => <String, dynamic>{
  if (instance.title case final value?) 'title': value,
  if (instance.description case final value?) 'description': value,
  if (instance.price case final value?) 'price': value,
  if (instance.city case final value?) 'city': value,
  if (_$RealEstateCategoryEnumMap[instance.category] case final value?)
    'category': value,
  if (_$RealEstatePropertyTypeEnumMap[instance.propertyType] case final value?)
    'property_type': value,
  if (_$RealEstatePropertyDeedTypeEnumMap[instance.deedType] case final value?)
    'property_deed_type': value,
  if (instance.propertySize case final value?) 'property_size': value,
  if (instance.room case final value?) 'room': value,
  if (instance.bathrooms case final value?) 'bathrooms': value,
  if (instance.propertyAge case final value?) 'property_age': value,
  if (instance.floor case final value?) 'floor': value,
  if (instance.stock case final value?) 'stock': value,
  if (instance.location?.toJson() case final value?) 'location': value,
  if (instance.neighborhood case final value?) 'neighborhood': value,
  if (instance.images case final value?) 'images': value,
  if (_$RealEstateStatusEnumMap[instance.status] case final value?)
    'status': value,
  if (instance.phoneCountryCode case final value?) 'phoneCountryCode': value,
  if (instance.phoneOwner case final value?) 'phoneOwner': value,
};

const _$RealEstateCategoryEnumMap = {
  RealEstateCategory.buy: 'buy',
  RealEstateCategory.rent: 'rent',
  RealEstateCategory.swap: 'swap',
};

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

const _$RealEstateStatusEnumMap = {
  RealEstateStatus.sold: 'sold',
  RealEstateStatus.rented: 'rented',
  RealEstateStatus.available: 'available',
};
