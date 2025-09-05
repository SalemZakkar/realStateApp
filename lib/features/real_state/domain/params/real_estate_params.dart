import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/real_state/data/model/real_estate_params_model/real_estate_params_model.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate_location.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_status.dart';

class RealEstateParams {
  String? id;
  String? title;
  String? description;
  double? price;
  City? city;
  RealEstateCategory? category;
  RealEstatePropertyType? propertyType;
  RealEstatePropertyDeedType? deedType;
  double? propertySize;
  int? room;
  int? bathrooms;
  int? propertyAge;
  int? floor;
  int? stock;
  RealEstateLocation? location;
  String? neighborhood;
  List<String>? images;
  RealEstateStatus? status;

  RealEstateParams({
    this.id,
    this.deedType,
    this.category,
    this.title,
    this.city,
    this.propertyType,
    this.bathrooms,
    this.propertyAge,
    this.propertySize,
    this.neighborhood,
    this.price,
    this.description,
    this.location,
    this.images,
    this.room,
    this.floor,
    this.stock,
    this.status,
  });

  factory RealEstateParams.fromRealEstate({required RealEstate realEstate}) {
    return RealEstateParams(
      id: realEstate.id,
      title: realEstate.title,
      description: realEstate.description,
      price: realEstate.price,
      city: realEstate.city,
      neighborhood: realEstate.neighborhood,
      location: realEstate.location,
      propertySize: realEstate.size,
      room: realEstate.room,
      bathrooms: realEstate.bathrooms,
      propertyAge: realEstate.propertyAge,
      images: realEstate.images,
      propertyType: realEstate.propertyType,
      category: realEstate.category,
      deedType: realEstate.propertyDeedType,
      // floor: realEstate.f
      stock: realEstate.stock,
      floor: realEstate.floor,
    );
  }

  RealEstateParamsModel toData() => RealEstateParamsModel(
    id: id,
    floor: floor,
    stock: stock,
    category: category,
    bathrooms: bathrooms,
    city: city?.id,
    deedType: deedType,
    description: description,
    images: images,
    location: location?.toData(),
    neighborhood: neighborhood,
    price: price,
    propertyAge: propertyAge,
    propertySize: propertySize,
    propertyType: propertyType,
    room: room,
    title: title,
    status: status,
  );
}
