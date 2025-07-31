// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'otp_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpStatusModel _$OtpStatusModelFromJson(Map json) => OtpStatusModel(
  const CustomNonNullableDateTimeConverter().fromJson(
    json['nextRequestAt'] as String,
  ),
  $enumDecode(_$OtpStatusTypeEnumMap, json['status']),
);

const _$OtpStatusTypeEnumMap = {
  OtpStatusType.success: 'success',
  OtpStatusType.failure: 'failure',
};
