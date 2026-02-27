import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/configuration.dart';
import 'package:real_state/features/ad_banner/data/models/ad_banner_model/ad_banner_model.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:retrofit/retrofit.dart';

part 'ad_banner_remote_source.g.dart';

abstract class AdBannerRemoteSource {
  Future<BaseResponse<List<AdBannerModel>>> getBanner();
}

@RestApi()
@Injectable(as: AdBannerRemoteSource)
abstract class AdBannerRemoteSourceImpl extends AdBannerRemoteSource {
  @factoryMethod
  factory AdBannerRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _AdBannerRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @GET("adBanner")
  @override
  Future<BaseResponse<List<AdBannerModel>>> getBanner();
}
