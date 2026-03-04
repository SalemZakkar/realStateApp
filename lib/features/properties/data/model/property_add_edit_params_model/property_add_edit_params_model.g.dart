// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'property_add_edit_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PropertyAddEditParamsModelToJson(
  PropertyAddEditParamsModel instance,
) => <String, dynamic>{
  if (instance.price case final value?) 'price': value,
  if (instance.cityId case final value?) 'cityId': value,
  if (instance.neighborhood case final value?) 'neighborhood': value,
  if (instance.address case final value?) 'address': value,
  if (instance.size case final value?) 'size': value,
  if (instance.room case final value?) 'room': value,
  if (instance.bathrooms case final value?) 'bathrooms': value,
  if (_$PropertyTypeEnumMap[instance.propertyType] case final value?)
    'propertyType': value,
  if (_$PropertyCategoryEnumMap[instance.category] case final value?)
    'category': value,
  if (_$PropertyDeedTypeEnumMap[instance.propertyDeedType] case final value?)
    'propertyDeedType': value,
  if (instance.floor case final value?) 'floor': value,
  if (instance.stocks case final value?) 'stocks': value,
  if (instance.lat case final value?) 'lat': value,
  if (instance.lng case final value?) 'lng': value,
};

const _$PropertyTypeEnumMap = {
  PropertyType.apartment: 'apartment',
  PropertyType.land: 'land',
  PropertyType.villa: 'villa',
  PropertyType.agriculturalLand: 'agriculturalLand',
  PropertyType.industrialLand: 'industrialLand',
  PropertyType.farm: 'farm',
  PropertyType.shop: 'shop',
  PropertyType.architecture: 'architecture',
};

const _$PropertyCategoryEnumMap = {
  PropertyCategory.buy: 'buy',
  PropertyCategory.rent: 'rent',
  PropertyCategory.swap: 'swap',
};

const _$PropertyDeedTypeEnumMap = {
  PropertyDeedType.green: 'green',
  PropertyDeedType.courtRolling: 'courtRolling',
  PropertyDeedType.municipal: 'municipal',
  PropertyDeedType.industrial: 'industrial',
  PropertyDeedType.agricultural: 'agricultural',
};
