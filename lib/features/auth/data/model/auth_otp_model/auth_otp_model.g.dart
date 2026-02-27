// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'auth_otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthOtpModel _$AuthOtpModelFromJson(Map json) => AuthOtpModel(
  vid: json['vid'] as String,
  sent: json['sent'] as bool,
  nextDate: const CustomNonNullableDateTimeConverter().fromJson(
    json['nextAttempt'] as String,
  ),
);
