import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate_location.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';

class RealEstateAddParams {
  String? id;
  String? title;
  String? description;
  double? price;
  City? city;
  String? neighborhood;
  String? address;
  RealEstateLocation? location;
  double? size;
  int? room;
  int? bathrooms;
  int? propertyAge;
  List<String>? images;
  RealEstatePropertyType? propertyType;
  RealEstateCategory? category;
  RealEstatePropertyDeedType? deedType;
  int? floor;
  int? stock;

  RealEstateAddParams({
    this.id,
    this.deedType,
    this.category,
    this.title,
    this.city,
    this.propertyType,
    this.bathrooms,
    this.propertyAge,
    this.size,
    this.address,
    this.neighborhood,
    this.price,
    this.description,
    this.location,
    this.images,
    this.room,
    this.floor,
    this.stock,
  });

  factory RealEstateAddParams.fromRealEstate({required RealEstate realEstate}) {
    return RealEstateAddParams(
      id: realEstate.id,
      title: realEstate.title,
      description: realEstate.description,
      price: realEstate.price,
      city: realEstate.city,
      neighborhood: realEstate.neighborhood,
      address: realEstate.address,
      location: realEstate.location,
      size: realEstate.size,
      room: realEstate.room,
      bathrooms: realEstate.bathrooms,
      propertyAge: realEstate.propertyAge,
      images: realEstate.images,
      propertyType: realEstate.propertyType,
      category: realEstate.category,
      deedType: realEstate.propertyDeedType,
      // floor: realEstate.f
    );
  }
}
