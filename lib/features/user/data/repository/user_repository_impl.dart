import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:real_state/features/user/data/source/user_remote_source/user_remote_source.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/repository/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository with ApiHandler {
  final UserRemoteSource source;

  UserRepositoryImpl(this.source);

  @override
  Future<Either<Failure, void>> changePassword({
    required String old,
    required String password,
    required String newPassword,
  }) {
    return request(() async {
      await source.changePassword(
        old: old,
        password: password,
        newPassword: newPassword,
      );
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, User>> getMine() {
    return request(() async {
      var res = await source.getMine();
      return Right(res.data!.toDomain());
    });
  }
}
