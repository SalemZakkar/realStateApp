import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/data/utils/custom_non_nullable_date_converter.dart';
import 'package:real_state/features/core/domain/entity/otp_status.dart';
import 'package:real_state/features/core/domain/enum/otp_status_type.dart';

part 'otp_status_model.g.dart';


@JsonSerializable()
class OtpStatusModel {
  @CustomNonNullableDateTimeConverter()
  @JsonKey(name: "nextRequestAt")
  DateTime nextDate;
  OtpStatusType status;

  OtpStatusModel(this.nextDate, this.status);

  factory OtpStatusModel.fromJson(Map<String, dynamic> json) =>
      _$OtpStatusModelFromJson(json);
}

extension MapToDomain on OtpStatusModel {
  OtpStatus toDomain() => OtpStatus(status: status, nextDate: nextDate);
}
