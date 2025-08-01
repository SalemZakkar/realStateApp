import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/core/presentation/widget/fields/phone_input_field.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: true)
class UserModel {
  String name;
  String email;
  String phone;
  String phoneCountryCode;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(defaultValue: true, name: "active")
  bool isActive;
  @JsonKey(defaultValue: false)
  bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.phone,
    required this.isActive,
    required this.isEmailVerified,
    required this.phoneCountryCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

extension MapToDomain on UserModel {
  User toDomain() => User(
    name: name,
    email: email,
    id: id,
    phoneNumber: PhoneNumber(phoneNumber: phone, dialCode: phoneCountryCode , isoCode: getIso(phoneCountryCode)),
    isActive: isActive,
    isEmailVerified: isEmailVerified,
  );
}

extension MapFromDomain on User {
  UserModel toData() => UserModel(
    name: name,
    email: email,
    id: id,
    phone: phoneNumber.phoneNumber!,
    phoneCountryCode: phoneNumber.dialCode!,
    isActive: isActive,
    isEmailVerified: isEmailVerified,
  );
}
