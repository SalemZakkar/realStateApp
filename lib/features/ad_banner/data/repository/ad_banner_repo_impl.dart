import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/ad_banner/data/source/remote/ad_banner_remote_source.dart';
import 'package:real_state/features/ad_banner/domain/entity/ad_banner.dart';
import 'package:real_state/features/ad_banner/domain/repository/ad_banner_repository.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';

@Injectable(as: AdBannerRepository)
class AdBannerRepoImpl extends AdBannerRepository with ApiHandler {
  AdBannerRemoteSource source;

  AdBannerRepoImpl(this.source);

  @override
  Future<Either<Failure, List<AdBanner>>> getAdBanner() {
    return request(() async {
      var res = await source.getBanner();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }
}
