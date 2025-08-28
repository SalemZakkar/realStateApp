import 'package:json_annotation/json_annotation.dart';

enum RealEstatePropertyDeedType {
  @JsonValue('green')
  green,
  @JsonValue('courtRolling')
  courtRolling,
  @JsonValue('municipal')
  municipal,
  @JsonValue('farm')
  farm,
  @JsonValue('industrial')
  industrial,
  @JsonValue('agricultural')
  agricultural,
  // @JsonValue('stock')
  // stock
  
}
