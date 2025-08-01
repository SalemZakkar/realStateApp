import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/source/core_remote_source/core_remote_source.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/entity/contact_item.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';

@Injectable(as: CoreRepository)
class CoreRepoImpl extends CoreRepository with ApiHandler {
  CoreRemoteSource source;

  CoreRepoImpl(this.source);

  @override
  Future<Either<Failure, List<City>>> getCities() {
    return request(() async {
      var res = await source.getCities();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }

  @override
  Future<Either<Failure, List<ContactItem>>> getContacts() {
    return request(() async {
      var res = await source.getContacts();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }
}
