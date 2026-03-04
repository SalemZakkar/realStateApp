import 'package:core_package/core_package.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';

class PropertyAddEditParams {
  int? price;
  City? city;
  String? neighborhood;
  String? address;
  int? size;
  int? room;
  int? bathrooms;
  PropertyType? propertyType;
  PropertyCategory? category;
  PropertyDeedType? propertyDeedType;
  int? floor;
  int? stocks;
  LatLng? latLng;

  PropertyAddEditParams clone() => PropertyAddEditParams(
    stocks: stocks,
    city: city,
    bathrooms: bathrooms,
    floor: floor,
    room: room,
    address: address,
    neighborhood: neighborhood,
    category: category,
    price: price,
    propertyDeedType: propertyDeedType,
    propertyType: propertyType,
    size: size,
    latLng: latLng,
  );

  factory PropertyAddEditParams.fromProperty(Property property) {
    return PropertyAddEditParams(
      latLng: property.coordinates,
      size: property.size,
      propertyType: property.propertyType,
      propertyDeedType: property.propertyDeedType,
      price: property.price,
      category: property.category,
      neighborhood: property.neighborhood,
      address: property.address,
      room: property.room,
      floor: property.floor,
      bathrooms: property.bathrooms,
      city: property.city,
      stocks: property.stocks,
    );
  }

  PropertyAddEditParams({
    this.price,
    this.stocks,
    this.latLng,
    this.bathrooms,
    this.floor,
    this.room,
    this.address,
    this.neighborhood,
    this.category,
    this.propertyDeedType,
    this.propertyType,
    this.size,
    this.city,
  });
}
