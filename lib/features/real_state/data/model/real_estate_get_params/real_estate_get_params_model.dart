import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/real_state/domain/enum/category_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_type.dart';

import '../../../domain/params/real_estate_get_params.dart';

part 'real_estate_get_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class RealEstateGetParamsModel {
  int? page, limit;
  @JsonKey(name: "price[gte]")
  double? minPrice;
  @JsonKey(name: "price[lte]")
  double? maxPrice;
  @JsonKey(name: "keyword")
  String? title;
  @JsonKey(name: "isFavorite")
  bool? isFavourite;
  String? city;
  @JsonKey(name: "property_deed_type")
  RealEstatePropertyDeedType? propertyDeedType;
  @JsonKey(name: "property_type")
  RealEstatePropertyType? propertyType;
  RealEstateCategory? category;
  @JsonKey(name: "property_size[gte]")
  double? minSize;
  @JsonKey(name: "property_size[lte]")
  double? maxSize;

  RealEstateGetParamsModel({
    this.page,
    this.limit,
    this.minPrice,
    this.maxPrice,

    this.title,
    this.isFavourite,
    this.city,
    this.category,
    this.propertyType,
    this.propertyDeedType,
    this.maxSize,
    this.minSize,
  });

  Map<String, dynamic> toJson() => _$RealEstateGetParamsModelToJson(this);
}

extension MapF on RealEstateGetParams {
  RealEstateGetParamsModel toModel() => RealEstateGetParamsModel(
    page: page,
    limit: limit,
    minPrice: minPrice,
    maxPrice: maxPrice,
    title: title,
    isFavourite: isFavourite,
    city: city?.id,
    propertyDeedType: propertyDeedType,
    propertyType: propertyType,
    category: category,
    maxSize: maxSize,
    minSize: minSize,
  );
}
