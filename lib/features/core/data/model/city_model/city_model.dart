import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/domain/entity/city.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  String name;
  @JsonKey(name: "_id")
  String id;

  CityModel(this.id, this.name);

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  City toDomain() => City(name: name, id: id);
}
