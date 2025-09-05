import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate_location.dart';

part 'real_estate_location_model.g.dart';

@JsonSerializable()
class RealEstateLocationModel {
  double lat, lng;

  RealEstateLocationModel({required this.lat, required this.lng});

  factory RealEstateLocationModel.fromJson(Map<String, dynamic> json) =>
      _$RealEstateLocationModelFromJson(json);

  RealEstateLocation toDomain() => RealEstateLocation(lat: lat, lng: lng);

  Map<String, dynamic> toJson() => {
    "type": "Point",
    "coordinates": [lat , lng],
  };
}
