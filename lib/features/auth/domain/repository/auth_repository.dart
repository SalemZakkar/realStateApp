import 'package:dartz/dartz.dart';
import 'package:real_state/features/auth/domain/params/auth_sign_up_params.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/domain/entity/otp_status.dart';
import 'package:real_state/features/core/domain/entity/user_stream_signal.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

import '../params/auth_sign_in_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({required AuthSignInParams params});

  Future<Either<Failure, User>> register({required AuthSignUpParams params});

  Future<void> logout();

  Future<Either<Failure, User>> verifyUser({required String code});

  Future<Either<Failure, OtpStatus>> requestOtpVerify({required String email});

  Future<Either<Failure, OtpStatus>> requestOtpPassword({
    required String email,
  });

  Future<Either<Failure, void>> verifyOtpPassword({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
  });

  Future<String> getToken();

  Stream<UserStreamSignal> get authStream;
}
