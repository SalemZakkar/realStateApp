import 'package:json_annotation/json_annotation.dart';

enum ContactType {
  @JsonValue("whatsapp")
  whatsapp,
  @JsonValue("instagram")
  instagram,
  @JsonValue("call")
  call,
  @JsonValue("telegram")
  telegram,
  @JsonValue("facebook")
  facebook,
}
