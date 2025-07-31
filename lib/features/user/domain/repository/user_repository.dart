import 'package:dartz/dartz.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getMine();

  Future<Either<Failure, void>> changePassword({
    required String old,
    required String password,
    required String newPassword,
  });
}
