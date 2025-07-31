import 'package:json_annotation/json_annotation.dart';

enum OtpStatusType {
  @JsonValue('success')
  success,
  @JsonValue('failure')
  failure,
}