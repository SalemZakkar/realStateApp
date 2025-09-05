import 'package:dartz/dartz.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/domain/entity/paginated_list.dart';
import 'package:real_state/features/core/domain/entity/picked_file.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';

abstract class RealEstateRepository {
  Future<Either<Failure, PaginatedList<RealEstate>>> getRealEstates({
    required RealEstateGetParams params,
  });

  Future<Either<Failure, List<RealEstate>>> getRealEstatesMap({
    required RealEstateGetParams params,
  });

  Future<Either<Failure, void>> save({required String id});

  Future<Either<Failure, void>> unSave({required String id});

  Future<Either<Failure, RealEstate>> create({
    required RealEstateParams params,
  });

  Future<Either<Failure, RealEstate>> edit({required RealEstateParams params});

  Future<Either<Failure, void>> delete({required String id});

  Future<Either<Failure, RealEstate>> addImage({
    required String id,
    required PickFile file,
  });

  Future<Either<Failure, void>> deleteImage({required String image});

  Future<Either<Failure, PaginatedList<RealEstate>>> getMineList({
    required RealEstateGetParams params,
  });
}
