import 'package:json_annotation/json_annotation.dart';

enum PropertyType {
  @JsonValue('apartment')
  apartment,
  @JsonValue('land')
  land,
  @JsonValue('villa')
  villa,
  @JsonValue('agricultural-land')
  agriculturalLand,
  @JsonValue('industrial-land')
  industrialLand,
  @JsonValue('farm')
  farm,
  @JsonValue('shop')
  shop,
  @JsonValue('architecture')
  architecture,
}
