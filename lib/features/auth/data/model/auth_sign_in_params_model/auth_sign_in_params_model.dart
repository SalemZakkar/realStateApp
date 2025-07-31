import 'package:json_annotation/json_annotation.dart';
import '../../../domain/params/auth_sign_in_params.dart';

part 'auth_sign_in_params_model.g.dart';

@JsonSerializable(createToJson: true, createFactory: false)
class AuthSignInParamsModel {
  String email;
  String password;

  AuthSignInParamsModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$AuthSignInParamsModelToJson(this);
}

extension C on AuthSignInParams {
  AuthSignInParamsModel toData() => AuthSignInParamsModel(
    email: email!,
    password: password!,

  );
}
