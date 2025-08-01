import 'package:dartz/dartz.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getMine();

  Future<Either<Failure, void>> changePassword({
    required String old,
    required String password,
    required String newPassword,
  });

  Future<Either<Failure, User>> updateUser({
    required UserUpdateParams params
  });


}
