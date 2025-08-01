import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/data/model/auth_sign_in_params_model/auth_sign_in_params_model.dart';
import 'package:real_state/features/auth/data/model/auth_sign_up_params/auth_sign_up_params_model.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/core/data/model/otp_status_model/otp_status_model.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/domain/entity/configuration.dart';

part 'auth_remote_source.g.dart';

abstract class AuthRemoteSource {
  Future login({required AuthSignInParamsModel params});

  Future signUp({required AuthSignUpParamsModel params});

  Future<OtpStatusModel> requestEmailVerify({required String email});

  Future<BaseResponse<UserModel>> verifyEmail({required String code});

  Future<OtpStatusModel> requestPasswordOtp({required String email});

  Future<void> verifyPasswordOtp({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
  });
}

@RestApi()
@Injectable(as: AuthRemoteSource)
abstract class AuthRemoteImpl extends AuthRemoteSource {
  @factoryMethod
  factory AuthRemoteImpl(Dio dio, Configuration configuration) {
    return _AuthRemoteImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @POST("auth/login")
  @override
  Future login({@Body() required AuthSignInParamsModel params});

  @POST("auth/signup/send-otp")
  @override
  Future<OtpStatusModel> requestEmailVerify({@Field() required String email});

  @POST("auth/signup")
  @override
  Future signUp({@Body() required AuthSignUpParamsModel params});

  @POST("auth/verify-email-code")
  @override
  Future<BaseResponse<UserModel>> verifyEmail({@Field() required String code});

  @POST("auth/forgotPassword")
  @override
  Future<OtpStatusModel> requestPasswordOtp({@Field() required String email});

  @POST("auth/verifyResetCode")
  @override
  Future<void> verifyPasswordOtp({
    @Field() required String email,
    @Field("resetCode") required String code,
    @Field("newPassword") required String password,
    @Field() required String confirmPassword,
  });
}
