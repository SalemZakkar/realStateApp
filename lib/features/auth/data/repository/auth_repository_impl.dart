import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/data/model/auth_otp_model/auth_otp_model.dart';
import 'package:real_state/features/auth/data/source/auth_local_source/auth_local_source.dart';
import 'package:real_state/features/auth/data/source/auth_remote_source/auth_remote_source.dart';
import 'package:real_state/features/auth/domain/entity/auth_otp.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/user_stream_signal.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository with ApiHandler {
  AuthLocalSource localSource;
  AuthRemoteSource remoteSource;

  AuthRepositoryImpl(this.localSource, this.remoteSource);

  StreamController<UserStreamSignal> controller = StreamController.broadcast();

  @override
  Future<String> getToken() async {
    String? k = (await localSource.getToken());
    if (k == null) {
      throw Exception("UnAuth");
    }
    return k;
  }

  @override
  Stream<UserStreamSignal> get authStream => controller.stream;

  @override
  Future<void> logout() async {
    await localSource.clear();
    controller.add(UserStreamSignal(withPush: true, user: null));
  }

  @override
  Future<Either<Failure, void>> login(String vid, String code) {
    return request(() async {
      var res = await remoteSource.login(vid, code);
      var token = res['accessToken'];
      var rToken = res['refreshToken'];
      var user = UserModel.fromJson(res['data']).toDomain();
      await localSource.setTokens(token: token, refToken: rToken);
      controller.add(UserStreamSignal(withPush: true, user: user));
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, AuthOtp>> requestOtp(String phone) async {
    return request(() async {
      var res = await remoteSource.requestLoginOtp(phone);
      var otp = AuthOtpModel.fromJson(res).toDomain();
      return Right(otp);
    });
  }
}
