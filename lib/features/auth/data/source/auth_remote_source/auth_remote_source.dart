import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:real_state/configuration.dart';

part 'auth_remote_source.g.dart';

abstract class AuthRemoteSource {
  Future requestLoginOtp(String phoneNumber);

  Future login(String vid, String code);
}

@RestApi()
@Injectable(as: AuthRemoteSource)
abstract class AuthRemoteImpl extends AuthRemoteSource {
  @factoryMethod
  factory AuthRemoteImpl(Dio dio, Configuration configuration) {
    return _AuthRemoteImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @POST("auth/loginOtp")
  @override
  Future login(
    @Field() String vid,
    @Field() String code,
  );

  @POST("auth/requestLoginOtp")
  @override
  Future<dynamic> requestLoginOtp(@Field() String phoneNumber);
}
