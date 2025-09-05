import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/real_state/data/model/real_estate_location_model/real_estate_location_model.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_status.dart';

part 'real_estate_params_model.g.dart';


@JsonSerializable(createToJson: true, createFactory: false)
class RealEstateParamsModel {
  @JsonKey(includeToJson: false)
  String? id;
  String? title;
  String? description;
  double? price;
  String? city;
  RealEstateCategory? category;
  @JsonKey(name: "property_type")
  RealEstatePropertyType? propertyType;
  @JsonKey(name: "property_deed_type")
  RealEstatePropertyDeedType? deedType;
  @JsonKey(name: "property_size")
  double? propertySize;
  int? room;
  int? bathrooms;
  @JsonKey(name: "property_age")
  int? propertyAge;
  int? floor;
  int? stock;
  RealEstateLocationModel? location;
  String? neighborhood;
  List<String>? images;
  RealEstateStatus? status;

  RealEstateParamsModel({
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

  Map<String, dynamic> toJson() => _$RealEstateParamsModelToJson(this);
}
