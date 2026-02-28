import 'package:core_package/core_package.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';

abstract class PropertiesRepository {
  Future<Either<Failure, PaginatedList<Property>>> getProperties(
    PropertyGetParams params,
  );
  Future<Either<Failure, Property>> getById(String id);
}
