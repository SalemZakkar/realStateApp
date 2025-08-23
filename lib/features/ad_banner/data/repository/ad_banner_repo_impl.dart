import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/ad_banner/domain/entity/ad_banner.dart';
import 'package:real_state/features/ad_banner/domain/repository/ad_banner_repository.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';

@Injectable(as: AdBannerRepository)
class AdBannerRepoImpl extends AdBannerRepository with ApiHandler {
  @override
  Future<Either<Failure, List<AdBanner>>> getAdBanner() {
    return request(() async {
      return Right([
        AdBanner(
          url: "https://google.com",
          image:
              "https://thumbs.dreamstime.com/b/residential-real-estate-buying-selling-renting-homes-apartments-condos-townhouses-investment-shelter-expert-guidance-318813833.jpg",
        ),
        AdBanner(
          url: "https://google.com",
          image:
              "https://media.istockphoto.com/id/1409298953/photo/real-estate-agents-shake-hands-after-the-signing-of-the-contract-agreement-is-complete.jpg?s=612x612&w=0&k=20&c=SFybbpGMB0wIoI0tJotFqptzAYK_mICVITNdQIXqnyc=",
        ),
        AdBanner(
          url: "https://google.com",
          image:
              "https://images.pexels.com/photos/1546168/pexels-photo-1546168.jpeg?cs=srgb&dl=pexels-davidmcbee-1546168.jpg&fm=jpg",
        ),
      ]);
    });
  }
}
