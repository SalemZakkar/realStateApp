import 'package:core_package/core_package.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/params/property_create_params.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/domain/params/property_map_params.dart';

abstract class PropertiesRepository {
  Future<Either<Failure, PaginatedList<Property>>> getProperties(
    PropertyGetParams params,
  );

  Future<Either<Failure, Property>> getById(String id);

  Future<Either<Failure, void>> delete(String id);

  Future<Either<Failure, Property>> create(PropertyAddEditParams params);

  Future<Either<Failure, Property>> edit(
    String id,
    PropertyAddEditParams params,
  );

  Future<Either<Failure, Property>> changeStatus(
    String id,
    PropertyStatus status,
  );

  Future<Either<Failure, Property>> addImage(String id, PickFile image);

  Future<Either<Failure, Property>> addVideo(String id, PickFile image);

  Future<Either<Failure, Property>> deleteImage(String id, String image);

  Future<Either<Failure, Property>> deleteVideo(String id, String video);

  Future<Either<Failure, void>> save(String id);

  Future<Either<Failure, void>> unSave(String id);

  Stream<Property> get newPropertyStream;

  Stream<String> get deletedPropertyStream;

  Stream<String> get saveStream;

  Future<Either<Failure, List<Property>>> getMap(PropertyMapParams params);
}
