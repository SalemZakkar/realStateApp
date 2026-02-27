import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/model/about_us_model/about_us_model.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/core/data/model/city_model/city_model.dart';
import 'package:retrofit/retrofit.dart';

import 'package:real_state/configuration.dart';

part 'core_remote_source.g.dart';

abstract class CoreRemoteSource {
  Future<BaseResponse<List<CityModel>>> getCities();

  Future<BaseResponse<AboutUsModel>> getAboutUs();
}

@RestApi()
@Injectable(as: CoreRemoteSource)
abstract class CoreRemoteSourceImpl extends CoreRemoteSource {
  @factoryMethod
  factory CoreRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _CoreRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @GET("aboutUs")
  @override
  Future<BaseResponse<AboutUsModel>> getAboutUs();

  @GET("city")
  @override
  Future<BaseResponse<List<CityModel>>> getCities();
}
