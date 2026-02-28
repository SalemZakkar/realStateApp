import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/properties/data/model/property_model/property_model.dart';
import 'package:real_state/features/properties/data/source/remote/properties_remote_source.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

import '../model/property_get_params_model/property_get_params_model.dart';

@Singleton(as: PropertiesRepository)
class PropertiesRepoImpl extends PropertiesRepository with ApiHandler {
  PropertiesRemoteSource propertiesRemoteSource;

  PropertiesRepoImpl(this.propertiesRemoteSource);

  @override
  Future<Either<Failure, Property>> getById(String id) {
    return request(() async {
      final response = await propertiesRemoteSource.getById(id);
      return Right(response.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, PaginatedList<Property>>> getProperties(
    PropertyGetParams params,
  ) {
    return request(() async {
      final response = await propertiesRemoteSource.getProperty(
        params.fromDomain(),
      );
      return Right(
        PaginatedList(
          hasReachedEnd:
              (params.skip ?? 0) >= response.data!.length ||
              response.totalRecords! <= response.data!.length,
          totalRecords: response.totalRecords!,
          data: response.data!.map((e) => e.toDomain()).toList(),
        ),
      );
    });
  }
}
