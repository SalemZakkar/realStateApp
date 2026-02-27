import 'package:core_package/core_package.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getMine();

  Future<Either<Failure, User>> updateUser({
    required UserUpdateParams params
  });

  Future<Either<Failure , User>> deletePhoto();
}
