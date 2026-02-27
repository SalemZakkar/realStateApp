import 'package:core_package/core_package.dart';
import 'package:real_state/features/auth/domain/entity/auth_otp.dart';
import 'package:real_state/features/core/domain/entity/user_stream_signal.dart';

abstract class AuthRepository {
  Future<String> getToken();

  Stream<UserStreamSignal> get authStream;

  Future<void> logout();

  Future<Either<Failure, AuthOtp>> requestOtp(String phone);

  Future<Either<Failure, void>> login(String vid, String code);
}
