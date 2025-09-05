import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/domain/entity/paginated_list.dart';
import 'package:real_state/features/core/domain/entity/picked_file.dart';
import 'package:real_state/features/real_state/data/model/real_estate_get_params/real_estate_get_params_model.dart';
import 'package:real_state/features/real_state/data/source/real_estate_remote_source/real_estate_remote_source.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart';

@Injectable(as: RealEstateRepository)
class RealEstateRepositoryImpl extends RealEstateRepository with ApiHandler {
  RealEstateRemoteSource source;

  RealEstateRepositoryImpl(this.source);

  @override
  Future<Either<Failure, PaginatedList<RealEstate>>> getRealEstates({
    required RealEstateGetParams params,
  }) {
    return request(() async {
      // throw Exception();
      var res = await source.getRealEstates(params: params.toModel());
      return Right(
        PaginatedList(
          res.totalRecords!,
          res.data!.map((e) => e.toDomain()).toList(),
        ),
      );
    });
  }

  @override
  Future<Either<Failure, List<RealEstate>>> getRealEstatesMap({
    required RealEstateGetParams params,
  }) {
    return request(() async {
      var res = await source.getRealEstatesMap(params: params.toModel());
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }

  @override
  Future<Either<Failure, void>> save({required String id}) async {
    return request(() async {
      await source.like(id: id);
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, void>> unSave({required String id}) {
    return request(() async {
      await source.unLike(id: id);
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, RealEstate>> create({
    required RealEstateParams params,
  }) {
    return request(() async {
      var res = await source.create(
        params: FormData.fromMap(params.toData().toJson()),
      );
      return right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, void>> delete({required String id}) {
    return request(() async {
      await source.delete(id: id);
      return right(null);
    });
  }

  @override
  Future<Either<Failure, RealEstate>> edit({required RealEstateParams params}) {
    return request(() async {
      var res = await source.edit(params: params.toData(), id: params.id!);
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, RealEstate>> addImage({
    required String id,
    required PickFile file,
  }) {
    return request(() async {
      var res = await source.addApartmentImage(
        form: FormData.fromMap({
          "images": [file.multipartFile],
        }),
        id: id,
      );
      return Right(res.data!.toDomain());
    });
  }

  @override
  Future<Either<Failure, void>> deleteImage({required String image}) {
    return request(() async {
      await source.deleteApartmentImage(image: image);
      return Right(null);
    });
  }

  @override
  Future<Either<Failure, PaginatedList<RealEstate>>> getMineList({
    required RealEstateGetParams params,
  }) {
    return request(() async {
      var res = await source.getMineList(params: params.toModel());
      return Right(
        PaginatedList(
          res.totalRecords!,
          res.data!.map((e) => e.toDomain()).toList(),
        ),
      );
    });
  }
}
