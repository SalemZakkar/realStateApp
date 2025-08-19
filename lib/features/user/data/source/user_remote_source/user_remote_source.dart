import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'package:real_state/configuration.dart';

part 'user_remote_source.g.dart';


abstract class UserRemoteSource {
  Future<BaseResponse<UserModel>> getMine();

  Future<void> changePassword({
    required String old,
    required String password,
    required String newPassword,
  });

  Future<BaseResponse<UserModel>> updateUser({
    String? name,
    String? phoneCountryCode,
    String? phone,
  });
}

@RestApi()
@Injectable(as: UserRemoteSource)
abstract class UserRemoteSourceImpl extends UserRemoteSource {
  @factoryMethod
  factory UserRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _UserRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @PUT("users/changeMyPassword")
  @override
  Future<void> changePassword({
    @Field("currentPassword") required String old,
    @Field("password") required String password,
    @Field("passwordConfirm") required String newPassword,
  });

  @GET("users/getme")
  @override
  Future<BaseResponse<UserModel>> getMine();

  @PATCH("users/updateMe")
  @override
  Future<BaseResponse<UserModel>> updateUser({
    @Field() String? name,
    @Field() String? phoneCountryCode,
    @Field() String? phone,
  });
}
