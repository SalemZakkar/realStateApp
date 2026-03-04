import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/params/property_create_params.dart';

part 'property_add_edit_params_model.g.dart';

@JsonSerializable(createFactory: false, createToJson: true)
class PropertyAddEditParamsModel {
  int? price;
  String? cityId;
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
  double? lat;
  double? lng;

  PropertyAddEditParamsModel({
    this.price,
    this.cityId,
    this.neighborhood,
    this.address,
    this.size,
    this.room,
    this.bathrooms,
    this.propertyType,
    this.category,
    this.propertyDeedType,
    this.floor,
    this.stocks,
    this.lng,
    this.lat,
  });

  Map<String, dynamic> toJson() => _$PropertyAddEditParamsModelToJson(this);
}

extension MapFromDomain on PropertyAddEditParams {
  PropertyAddEditParamsModel fromDomain() => PropertyAddEditParamsModel(
    size: size,
    propertyType: propertyType,
    propertyDeedType: propertyDeedType,
    price: price,
    category: category,
    neighborhood: neighborhood,
    address: address,
    room: room,
    floor: floor,
    bathrooms: bathrooms,
    cityId: city?.id,
    lat: latLng!.latitude,
    lng: latLng!.longitude,
    stocks: stocks,
  );
}
