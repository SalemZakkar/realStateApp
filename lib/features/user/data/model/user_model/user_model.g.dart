// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) => UserModel(
  name: json['name'] as String,
  email: json['email'] as String,
  id: json['_id'] as String,
  phone: json['phone'] as String,
  isActive: json['active'] as bool? ?? true,
  isEmailVerified: json['isEmailVerified'] as bool? ?? false,
  phoneCountryCode: json['phoneCountryCode'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'phoneCountryCode': instance.phoneCountryCode,
  '_id': instance.id,
  'active': instance.isActive,
  'isEmailVerified': instance.isEmailVerified,
};
