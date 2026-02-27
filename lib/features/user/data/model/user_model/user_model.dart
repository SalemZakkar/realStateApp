import 'package:json_annotation/json_annotation.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: true)
class UserModel {
  String id;
  String? name;
  String? phone;
  bool isCompleted;
  String? image;

  @JsonKey(defaultValue: true, name: "active")
  bool isActive;

  UserModel({
    required this.name,
    required this.id,
    required this.phone,
    required this.isActive,
    required this.isCompleted,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

extension MapToDomain on UserModel {
  User toDomain() => User(
    name: name,
    id: id,
    isActive: isActive,
    isCompleted: isCompleted,
    phoneNumber: phone,
    image: image,
  );
}

extension MapFromDomain on User {
  UserModel toData() => UserModel(
    name: name,
    id: id,
    isActive: isActive,
    isCompleted: isCompleted,
    phone: phoneNumber,
    image: image,
  );
}
