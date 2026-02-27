import 'package:core_package/core_package.dart';
import 'package:real_state/features/ad_banner/domain/entity/ad_banner.dart';

abstract class AdBannerRepository {
  Future<Either<Failure, List<AdBanner>>> getAdBanner();
}
