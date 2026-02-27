import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/auth/domain/entity/auth_otp.dart';
import 'package:real_state/features/core/data/utils/custom_non_nullable_date_converter.dart';

part 'auth_otp_model.g.dart';

@JsonSerializable()
class AuthOtpModel {
  String vid;
  @JsonKey(name: "nextAttempt")
  @CustomNonNullableDateTimeConverter()
  DateTime nextDate;
  bool sent;

  AuthOtpModel({required this.vid, required this.sent, required this.nextDate});

  factory AuthOtpModel.fromJson(Map<String, dynamic> json) =>
      _$AuthOtpModelFromJson(json);

}

extension MapToDomain on AuthOtpModel {
  AuthOtp toDomain() => AuthOtp(nextDate: nextDate, sent: sent, vid: vid);
}

extension MapFromDomain on AuthOtp {
  AuthOtpModel fromDomain() =>
      AuthOtpModel(nextDate: nextDate, sent: sent, vid: vid);
}
