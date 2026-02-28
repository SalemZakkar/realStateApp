// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'property_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyModel _$PropertyModelFromJson(Map json) => PropertyModel(
  id: json['id'] as String,
  refNumber: json['refNumber'] as String,
  price: (json['price'] as num).toInt(),
  city: CityModel.fromJson(Map<String, dynamic>.from(json['city'] as Map)),
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  cover: json['cover'] as String?,
  neighborhood: json['neighborhood'] as String?,
  size: (json['size'] as num).toInt(),
  room: (json['room'] as num).toInt(),
  bathrooms: (json['bathrooms'] as num).toInt(),
  propertyAge: (json['propertyAge'] as num?)?.toInt(),
  propertyType: $enumDecode(_$PropertyTypeEnumMap, json['propertyType']),
  category: $enumDecode(_$PropertyCategoryEnumMap, json['category']),
  propertyDeedType: $enumDecode(
    _$PropertyDeedTypeEnumMap,
    json['propertyDeedType'],
  ),
  status: $enumDecode(_$PropertyStatusEnumMap, json['status']),
  isFeature: json['isFeature'] as bool,
  floor: (json['floor'] as num).toInt(),
  rejectReason: json['rejectReason'] as String?,
  notes: json['notes'] as String?,
  address: json['address'] as String?,
  owner: UserModel.fromJson(Map<String, dynamic>.from(json['owner'] as Map)),
  coordinates: LocationModel.fromJson(
    Map<String, dynamic>.from(json['coordinates'] as Map),
  ),
);

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
