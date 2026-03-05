import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/properties/domain/params/property_map_params.dart';

part 'property_map_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class PropertyMapParamsModel {
  double north, south, east, west;

  Map<String, dynamic> toJson() => _$PropertyMapParamsModelToJson(this);

  PropertyMapParamsModel({
    required this.south,
    required this.north,
    required this.east,
    required this.west,
  });
}

extension MapFromDomain on PropertyMapParams {
  PropertyMapParamsModel fromDomain() => PropertyMapParamsModel(
    east: east,
    north: north,
    south: south,
    west: west,
  );
}
