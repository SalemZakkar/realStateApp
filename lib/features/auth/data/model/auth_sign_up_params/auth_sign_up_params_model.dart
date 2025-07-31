import 'package:json_annotation/json_annotation.dart';

import '../../../domain/params/auth_sign_up_params.dart';

part 'auth_sign_up_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class AuthSignUpParamsModel {
  String email;
  String phone;
  String name;
  String password;
  String passwordConfirm;
  String phoneCountryCode;

  AuthSignUpParamsModel({
    required this.email,
    required this.phone,
    required this.name,
    required this.password,
    required this.passwordConfirm,
    required this.phoneCountryCode,
  });

  Map<String, dynamic> toJson() => _$AuthSignUpParamsModelToJson(this);
}

extension C on AuthSignUpParams {
  AuthSignUpParamsModel toData() => AuthSignUpParamsModel(
    email: email!,
    phone: phone!,
    name: name!,
    password: password!,
    passwordConfirm: confirmPassword!,
    phoneCountryCode: code!,
  );
}
