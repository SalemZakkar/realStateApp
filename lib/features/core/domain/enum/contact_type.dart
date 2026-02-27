import 'package:json_annotation/json_annotation.dart';

enum ContactType {
  @JsonValue("Instagram")
  instagram,
  @JsonValue("Phone")
  call,
  @JsonValue("Facebook")
  facebook,
}
