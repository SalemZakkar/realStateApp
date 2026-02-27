// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'contact_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactItemModel _$ContactItemModelFromJson(Map json) => ContactItemModel(
  type: $enumDecode(_$ContactTypeEnumMap, json['type']),
  value: json['value'] as String,
);

const _$ContactTypeEnumMap = {
  ContactType.instagram: 'Instagram',
  ContactType.call: 'Phone',
  ContactType.facebook: 'Facebook',
};
