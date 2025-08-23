// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'real_estate_get_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RealEstateGetParamsModelToJson(
  RealEstateGetParamsModel instance,
) => <String, dynamic>{
  if (instance.page case final value?) 'page': value,
  if (instance.limit case final value?) 'limit': value,
  if (instance.minPrice case final value?) 'price[gte]': value,
  if (instance.maxPrice case final value?) 'price[lte]': value,
  if (instance.title case final value?) 'keyword': value,
  if (instance.isFavourite case final value?) 'isFavorite': value,
  if (instance.city case final value?) 'city': value,
  if (_$RealEstatePropertyDeedTypeEnumMap[instance.propertyDeedType]
      case final value?)
    'property_deed_type': value,
  if (_$RealEstatePropertyTypeEnumMap[instance.propertyType] case final value?)
    'property_type': value,
  if (_$RealEstateCategoryEnumMap[instance.category] case final value?)
    'category': value,
  if (instance.minSize case final value?) 'property_size[gte]': value,
  if (instance.maxSize case final value?) 'property_size[lte]': value,
  if (instance.isFeatured case final value?) 'isFeatured': value,
};

const _$RealEstatePropertyDeedTypeEnumMap = {
  RealEstatePropertyDeedType.green: 'green',
  RealEstatePropertyDeedType.courtRolling: 'courtRolling',
  RealEstatePropertyDeedType.municipal: 'municipal',
  RealEstatePropertyDeedType.farm: 'farm',
  RealEstatePropertyDeedType.industrial: 'industrial',
  RealEstatePropertyDeedType.agricultural: 'agricultural',
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

const _$RealEstateCategoryEnumMap = {
  RealEstateCategory.buy: 'buy',
  RealEstateCategory.rent: 'rent',
};
