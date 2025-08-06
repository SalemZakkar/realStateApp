import 'package:json_annotation/json_annotation.dart';

import '../../../domain/params/real_estate_get_params.dart';

part 'real_estate_get_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class RealEstateGetParamsModel {
  int skip, limit;
  double? minPrice, maxPrice;
  String? title;
  bool? isFavourite;
  String? city;

  RealEstateGetParamsModel({
    required this.skip,
    required this.limit,
    this.minPrice,
    this.maxPrice,

    this.title,
    this.isFavourite,
    this.city,
  });

  Map<String, dynamic> toJson() => _$RealEstateGetParamsModelToJson(this);
}

extension MapF on RealEstateGetParams {
  RealEstateGetParamsModel toModel() => RealEstateGetParamsModel(
    skip: skip,
    limit: limit,
    minPrice: minPrice,
    maxPrice: maxPrice,
    title: title,
    isFavourite: isFavourite,
    city: city,
  );
}
