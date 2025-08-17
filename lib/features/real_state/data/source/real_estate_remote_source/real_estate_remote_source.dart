import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/real_state/data/model/real_estate_get_params/real_estate_get_params_model.dart';
import 'package:real_state/features/real_state/data/model/real_estate_model/real_estate_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/domain/entity/configuration.dart';

part 'real_estate_remote_source.g.dart';

abstract class RealEstateRemoteSource {
  Future<BaseResponse<List<RealEstateModel>>> getRealEstates({
    required RealEstateGetParamsModel params,
  });

  Future<BaseResponse<List<RealEstateModel>>> getRealEstatesMap({
    required RealEstateGetParamsModel params,
  });

  Future<void> like({required String id});

  Future<void> unLike({required String id});
}

@RestApi()
@Injectable(as: RealEstateRemoteSource)
abstract class RealEstateRemoteSourceImpl extends RealEstateRemoteSource {
  @factoryMethod
  factory RealEstateRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _RealEstateRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @GET("apartments/list")
  @override
  Future<BaseResponse<List<RealEstateModel>>> getRealEstates({
    @Queries() required RealEstateGetParamsModel params,
  });

  @GET("apartments/map")
  @override
  Future<BaseResponse<List<RealEstateModel>>> getRealEstatesMap({
    @Queries() required RealEstateGetParamsModel params,
  });

  @POST("wishlist")
  @override
  Future<void> like({@Field("apartmentId") required String id});

  @DELETE("wishlist/{id}")
  @override
  Future<void> unLike({@Path() required String id});
}
