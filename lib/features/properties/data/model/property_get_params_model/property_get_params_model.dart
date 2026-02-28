import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/domain/params/base_pagination_params.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';

part 'property_get_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class PropertyGetParamsModel {
  final int? skip;
  final int? limit;
  final BaseParamsSortType? price;
  final BaseParamsSortType? size;
  final String? owner;
  final String? city;
  final PropertyType? propertyType;
  final PropertyCategory? category;
  final PropertyDeedType? propertyDeedType;
  final bool? isFeature;
  final PropertyStatus? status;

  PropertyGetParamsModel({
    this.skip,
    this.limit,
    this.price,
    this.size,
    this.owner,
    this.city,
    this.propertyType,
    this.category,
    this.propertyDeedType,
    this.isFeature,
    this.status,
  });

  Map<String, dynamic> toJson() => _$PropertyGetParamsModelToJson(this);
}

extension MapFromDomain on PropertyGetParams {
  PropertyGetParamsModel fromDomain() => PropertyGetParamsModel(
    limit: limit,
    category: category,
    city: city,
    isFeature: isFeature,
    owner: owner,
    price: price,
    propertyDeedType: propertyDeedType,
    propertyType: propertyType,
    size: size,
    skip: skip,
    status: status,
  );
}
