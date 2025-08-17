import 'package:dartz/dartz.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/core/domain/entity/paginated_list.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';

abstract class RealEstateRepository {
  Future<Either<Failure, PaginatedList<RealEstate>>> getRealEstates({
    required RealEstateGetParams params,
  });

  Future<Either<Failure, List<RealEstate>>> getRealEstatesMap({
    required RealEstateGetParams params,
  });

  Future<Either<Failure, void>> save({required String id});

  Future<Either<Failure, void>> unSave({required String id});
}
