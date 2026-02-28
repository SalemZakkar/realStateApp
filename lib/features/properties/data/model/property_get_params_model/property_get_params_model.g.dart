// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'property_get_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PropertyGetParamsModelToJson(
  PropertyGetParamsModel instance,
) => <String, dynamic>{
  if (instance.skip case final value?) 'skip': value,
  if (instance.limit case final value?) 'limit': value,
  if (_$BaseParamsSortTypeEnumMap[instance.price] case final value?)
    'price': value,
  if (_$BaseParamsSortTypeEnumMap[instance.size] case final value?)
    'size': value,
  if (instance.owner case final value?) 'owner': value,
  if (instance.city case final value?) 'city': value,
  if (_$PropertyTypeEnumMap[instance.propertyType] case final value?)
    'propertyType': value,
  if (_$PropertyCategoryEnumMap[instance.category] case final value?)
    'category': value,
  if (_$PropertyDeedTypeEnumMap[instance.propertyDeedType] case final value?)
    'propertyDeedType': value,
  if (instance.isFeature case final value?) 'isFeature': value,
  if (_$PropertyStatusEnumMap[instance.status] case final value?)
    'status': value,
};

const _$BaseParamsSortTypeEnumMap = {
  BaseParamsSortType.desc: 'DESC',
  BaseParamsSortType.asc: 'ASC',
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

const _$PropertyStatusEnumMap = {
  PropertyStatus.unCompleted: 'unCompleted',
  PropertyStatus.pending: 'pending',
  PropertyStatus.rejected: 'rejected',
  PropertyStatus.active: 'active',
  PropertyStatus.unactive: 'unactive',
};
