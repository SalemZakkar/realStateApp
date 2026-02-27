import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:real_state/features/user/data/source/user_remote_source/user_remote_source.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/features/user/domain/repository/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository with ApiHandler {
  final UserRemoteSource source;

  UserRepositoryImpl(this.source);

  @override
  Future<Either<Failure, User>> getMine() {
    return request(() async {
      var res = await source.getMine();
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, User>> updateUser({required UserUpdateParams params}) {
    return request(() async {
      var res = await source.updateUser(
        body: FormData.fromMap({
          if (params.name != null) ...{"name": params.name},
          if (params.image != null) ...{"image": params.image!.multipartFile},
        }),
      );
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, User>> deletePhoto() {
    return request(() async {
      var res = await source.deletePhoto();
      return Right(res.data!.toDomain());
    });
  }
}
