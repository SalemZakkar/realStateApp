import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/data/model/city_model/city_model.dart';
import 'package:real_state/features/core/data/model/location_model/location_model.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';

part 'property_model.g.dart';

@JsonSerializable()
class PropertyModel {
  final String id;
  final String refNumber;
  final int price;
  final CityModel city;
  @JsonKey(defaultValue: [])
  final List<String> images;
  final String? cover;
  final String? neighborhood;
  final int size;
  final int room;
  final int bathrooms;
  final int? propertyAge;
  final PropertyType propertyType;
  final PropertyCategory category;
  final PropertyDeedType propertyDeedType;
  final PropertyStatus status;
  final bool isFeature;
  final int floor;
  final String? rejectReason;
  final String? notes;
  final String? address;
  final UserModel owner;
  final LocationModel coordinates;

  PropertyModel({
    required this.id,
    required this.refNumber,
    required this.price,
    required this.city,
    required this.images,
    this.cover,
    this.neighborhood,
    required this.size,
    required this.room,
    required this.bathrooms,
    this.propertyAge,
    required this.propertyType,
    required this.category,
    required this.propertyDeedType,
    required this.status,
    required this.isFeature,
    required this.floor,
    this.rejectReason,
    this.notes,
    this.address,
    required this.owner,
    required this.coordinates,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyModelFromJson(json);
}

extension MapToDomain on PropertyModel {
  Property toDomain() => Property(
    id: id,
    status: status,
    size: size,
    propertyType: propertyType,
    propertyDeedType: propertyDeedType,
    price: price,
    owner: owner.toDomain(),
    isFeature: isFeature,
    city: city.toDomain(),
    category: category,
    bathrooms: bathrooms,
    coordinates: coordinates.toDomain(),
    floor: floor,
    images: images,
    refNumber: refNumber,
    room: room,
    address: address,
    cover: cover,
    neighborhood: neighborhood,
    notes: notes,
    propertyAge: propertyAge,
    rejectReason: rejectReason,
  );
}
