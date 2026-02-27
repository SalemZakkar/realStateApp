import 'dart:async';
import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/model/about_us_model/about_us_model.dart';
import 'package:real_state/features/core/data/source/core_remote_source/core_remote_source.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/about_us.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';

@Singleton(as: CoreRepository)
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
  Future<Either<Failure, AboutUs>> getAboutUs() async {
    return request(() async {
      var res = await source.getAboutUs();
      return Right(res.data!.toDomain());
    });
  }
}
