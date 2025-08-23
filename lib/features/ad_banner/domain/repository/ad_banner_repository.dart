import 'package:dartz/dartz.dart';
import 'package:real_state/features/ad_banner/domain/entity/ad_banner.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';

abstract class AdBannerRepository {
  Future<Either<Failure, List<AdBanner>>> getAdBanner();
}
