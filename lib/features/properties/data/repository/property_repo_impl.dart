import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/properties/data/model/property_add_edit_params_model/property_add_edit_params_model.dart';
import 'package:real_state/features/properties/data/model/property_map_params_model/property_map_params_model.dart';
import 'package:real_state/features/properties/data/model/property_model/property_model.dart';
import 'package:real_state/features/properties/data/source/cache/property_cache_source.dart';
import 'package:real_state/features/properties/data/source/remote/properties_remote_source.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/params/property_create_params.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/domain/params/property_map_params.dart';
import 'package:real_state/features/properties/domain/repository/property_repository.dart';

import '../model/property_get_params_model/property_get_params_model.dart';

@Singleton(as: PropertiesRepository)
class PropertiesRepoImpl extends PropertiesRepository with ApiHandler {
  PropertiesRemoteSource propertiesRemoteSource;

  PropertiesRepoImpl(this.propertiesRemoteSource, this.cacheSource);

  StreamController<Property> addPropertyController =
      StreamController.broadcast();
  StreamController<String> deletePropertyController =
      StreamController.broadcast();

  StreamController<String> saveController = StreamController.broadcast();

  PropertyCacheSource cacheSource;

  @override
  Future<Either<Failure, Property>> getById(String id) {
    return request(() async {
      final response = await propertiesRemoteSource.getById(id);
      addPropertyController.add(response.data!.toDomain());
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
              (params.skip ?? 0) >= response.totalRecords! ||
              response.totalRecords! <= response.data!.length,
          totalRecords: response.totalRecords!,
          data: response.data!.map((e) => e.toDomain()).toList(),
        ),
      );
    });
  }

  @override
  Future<Either<Failure, Property>> addImage(String id, PickFile image) {
    return request(() async {
      var res = await propertiesRemoteSource.addImage(
        id,
        FormData.fromMap({"image": image.multipartFile}),
      );
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, Property>> addVideo(String id, PickFile image) {
    return request(() async {
      var res = await propertiesRemoteSource.video(
        id,
        FormData.fromMap({"video": image.multipartFile}),
      );
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, Property>> changeStatus(
    String id,
    PropertyStatus status,
  ) {
    return request(() async {
      var res = await propertiesRemoteSource.changeStatus(id, status.name);
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, Property>> create(PropertyAddEditParams params) {
    return request(() async {
      var res = await propertiesRemoteSource.create(params.fromDomain());
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, void>> delete(String id) {
    return request(() async {
      await propertiesRemoteSource.delete(id);
      deletePropertyController.add(id);
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, Property>> deleteImage(String id, String image) {
    return request(() async {
      var res = await propertiesRemoteSource.deleteImage(id, image);
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, Property>> deleteVideo(String id, String video) {
    return request(() async {
      var res = await propertiesRemoteSource.deleteVideo(id, video);
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, Property>> edit(
    String id,
    PropertyAddEditParams params,
  ) {
    return request(() async {
      var res = await propertiesRemoteSource.edit(id, params.fromDomain());
      addPropertyController.add(res.data!.toDomain());
      return Right(res.data!.toDomain());
    });
  }

  @override
  Stream<Property> get newPropertyStream => addPropertyController.stream;

  @override
  Stream<String> get deletedPropertyStream => deletePropertyController.stream;

  @override
  Future<Either<Failure, void>> save(String id) {
    return request(() async {
      saveController.add(id);
      cacheSource.save(id);
      await propertiesRemoteSource.save(id);
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, void>> unSave(String id) {
    return request(() async {
      saveController.add(id);
      cacheSource.unSave(id);
      await propertiesRemoteSource.unSave(id);
      return Right(null);
    });
  }

  @override
  Stream<String> get saveStream => saveController.stream;

  @override
  Future<Either<Failure, List<Property>>> getMap(PropertyMapParams params) {
    return request(() async {
      var res = await propertiesRemoteSource.getMap(params.fromDomain());
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }
}
