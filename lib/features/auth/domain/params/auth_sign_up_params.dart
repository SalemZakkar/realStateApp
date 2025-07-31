class AuthSignUpParams {
  String? email;
  String? phone;
  String? name;
  String? password;
  String? confirmPassword;
  String? code;

  AuthSignUpParams({
    this.password,
    this.email,
    this.name,
    this.phone,
    this.confirmPassword,
    this.code,
  });
}
