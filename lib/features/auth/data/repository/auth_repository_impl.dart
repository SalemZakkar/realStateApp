import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/data/model/auth_sign_in_params_model/auth_sign_in_params_model.dart';
import 'package:real_state/features/auth/data/model/auth_sign_up_params/auth_sign_up_params_model.dart';
import 'package:real_state/features/auth/data/source/auth_local_source/auth_local_source.dart';
import 'package:real_state/features/auth/data/source/auth_remote_source/auth_remote_source.dart';
import 'package:real_state/features/auth/domain/params/auth_sign_in_params.dart';
import 'package:real_state/features/auth/domain/params/auth_sign_up_params.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/data/model/otp_status_model/otp_status_model.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/domain/entity/otp_status.dart';
import 'package:real_state/features/core/domain/entity/user_stream_signal.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

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
  Future<Either<Failure, User>> login({
    required AuthSignInParams params,
  }) async {
    return request(() async {
      var res = await remoteSource.login(params: params.toData());
      UserModel userModel = UserModel.fromJson(res['data']);
      String token = res['token'];
      await localSource.setToken(token);
      controller.add(UserStreamSignal(user: userModel.toDomain()));
      return Right(userModel.toDomain());
    });
  }

  @override
  Future<void> logout() async {
    controller.add(UserStreamSignal());
    await localSource.clear();
  }

  @override
  Future<Either<Failure, User>> register({required AuthSignUpParams params}) {
    return request(() async {
      var res = await remoteSource.signUp(params: params.toData());
      UserModel userModel = UserModel.fromJson(res['data']);
      String token = res['token'];
      await localSource.setToken(token);
      controller.add(UserStreamSignal(user: userModel.toDomain()));
      return Right(userModel.toDomain());
    });
  }

  @override
  Future<Either<Failure, OtpStatus>> requestOtpVerify({required String email}) {
    return request(() async {
      var res = await remoteSource.requestEmailVerify(email: email);
      return Right(res.toDomain());
    });
  }

  @override
  Future<Either<Failure, User>> verifyUser({required String code}) {
    return request(() async {
      var res = await remoteSource.verifyEmail(code: code);
      controller.add(UserStreamSignal(user: res.data!.toDomain()));
      return Right(res.data!.toDomain());
    });
  }

  @override
  Stream<UserStreamSignal> get authStream => controller.stream;
}
