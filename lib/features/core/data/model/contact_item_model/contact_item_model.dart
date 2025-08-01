import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/domain/entity/contact_item.dart';
import 'package:real_state/features/core/domain/enum/contact_type.dart';

part 'contact_item_model.g.dart';

@JsonSerializable()
class ContactItemModel {
  String value;
  ContactType type;
  String? title;

  ContactItemModel({required this.type, required this.value, this.title});

  factory ContactItemModel.fromJson(Map<String, dynamic> json) =>
      _$ContactItemModelFromJson(json);

  ContactItem toDomain() => ContactItem(type: type, value: value, title: title);
}
