// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) => UserModel(
  name: json['name'] as String?,
  id: json['id'] as String,
  phone: json['phone'] as String?,
  isActive: json['active'] as bool? ?? true,
  isCompleted: json['isCompleted'] as bool,
  image: json['image'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  if (instance.name case final value?) 'name': value,
  if (instance.phone case final value?) 'phone': value,
  'isCompleted': instance.isCompleted,
  if (instance.image case final value?) 'image': value,
  'active': instance.isActive,
};
