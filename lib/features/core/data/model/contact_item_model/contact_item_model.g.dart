// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: prefer_const_declarations

part of 'contact_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactItemModel _$ContactItemModelFromJson(Map json) => ContactItemModel(
  type: $enumDecode(_$ContactTypeEnumMap, json['type']),
  value: json['value'] as String,
  title: json['title'],
);

const _$ContactTypeEnumMap = {
  ContactType.whatsapp: 'whatsapp',
  ContactType.instagram: 'instagram',
  ContactType.call: 'call',
  ContactType.telegram: 'telegram',
  ContactType.facebook: 'facebook',
};
