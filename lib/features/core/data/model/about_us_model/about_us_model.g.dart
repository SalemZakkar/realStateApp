// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'about_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map json) => AboutUsModel(
  privacyPolicy: json['privacyPolicy'] as String?,
  description: json['description'] as String?,
  facebookLink: json['facebookLink'] as String?,
  instagramLink: json['instagramLink'] as String?,
  phones:
      (json['phones'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  termsAndConditions: json['termsAndConditions'] as String?,
);
