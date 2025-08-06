// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'real_estate_get_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RealEstateGetParamsModelToJson(
  RealEstateGetParamsModel instance,
) => <String, dynamic>{
  'skip': instance.skip,
  'limit': instance.limit,
  if (instance.minPrice case final value?) 'minPrice': value,
  if (instance.maxPrice case final value?) 'maxPrice': value,
  if (instance.title case final value?) 'title': value,
  if (instance.isFavourite case final value?) 'isFavourite': value,
  if (instance.city case final value?) 'city': value,
};
