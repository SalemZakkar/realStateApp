import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/data/model/city_model/city_model.dart';
import 'package:real_state/features/real_state/data/model/real_estate_location_model/real_estate_location_model.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_post_status.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_status.dart';

part 'real_estate_model.g.dart';

@JsonSerializable()
class RealEstateModel {
  @JsonKey(name: "_id")
  final String id;
  final String title;
  double price;
  CityModel city;
  String neighborhood;
  String? address;
  RealEstateLocationModel location;
  @JsonKey(name: 'property_type')
  RealEstatePropertyType propertyType;
  @JsonKey(name: "property_size")
  double size;
  num room;
  num bathrooms;
  @JsonKey(name: "property_age")
  num? propertyAge;
  List<String> images;
  @JsonKey(name: "isFavorite")
  bool isFavourite;
  String? description;
  RealEstateCategory category;
  @JsonKey(name: "property_deed_type")
  RealEstatePropertyDeedType propertyDeedType;
  bool isFeature;
  String? owner;
  RealEstatePostStatus postStatus;
  RealEstateStatus status;
  @JsonKey(defaultValue: 0)
  num floor;
  @JsonKey(defaultValue: 0)
  num stock;
  String? rejectReason;

  RealEstateModel({
    required this.id,
    required this.title,
    required this.price,
    required this.city,
    required this.neighborhood,
    this.address,
    required this.location,
    required this.propertyType,
    required this.size,
    required this.room,
    required this.bathrooms,
    required this.propertyAge,
    required this.images,
    this.isFavourite = false,
    this.description,
    required this.propertyDeedType,
    required this.category,
    this.isFeature = false,
    this.owner,
    required this.postStatus,
    required this.status,
    required this.stock,
    required this.floor,
    this.rejectReason,
  });

  factory RealEstateModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateModelFromJson(json);

  RealEstate toDomain() => RealEstate(
    id: id,
    title: title,
    price: price,
    city: city.toDomain(),
    neighborhood: neighborhood,
    address: address,
    location: location.toDomain(),
    propertyType: propertyType,
    size: size,
    room: room.toInt(),
    bathrooms: bathrooms.toInt(),
    propertyAge: propertyAge?.toInt(),
    images: images,
    isFavourite: isFavourite,
    description: description,
    category: category,
    propertyDeedType: propertyDeedType,
    isFeature: isFeature,
    owner: owner,
    status: status,
    postStatus: postStatus,
    floor: floor.toInt(),
    stock: stock.toInt(),
    rejectReason: rejectReason,
  );
}
