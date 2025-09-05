import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/configuration.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/real_state/data/model/real_estate_get_params/real_estate_get_params_model.dart';
import 'package:real_state/features/real_state/data/model/real_estate_model/real_estate_model.dart';
import 'package:real_state/features/real_state/data/model/real_estate_params_model/real_estate_params_model.dart';
import 'package:retrofit/retrofit.dart';

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

  Future<BaseResponse<RealEstateModel>> create({required FormData params});

  Future<BaseResponse<RealEstateModel>> edit({
    required RealEstateParamsModel params,
    required String id,
  });

  Future<BaseResponse<RealEstateModel>> addApartmentImage({
    required FormData form,
    required String id,
  });

  Future<BaseResponse<RealEstateModel>> deleteApartmentImage({
    required String image,
  });

  Future<BaseResponse<RealEstateModel>> delete({required String id});

  Future<BaseResponse<List<RealEstateModel>>> getMineList({
    required RealEstateGetParamsModel params,
  });
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

  @POST("users/addApartment")
  @override
  Future<BaseResponse<RealEstateModel>> create({
    @Body() required FormData params,
  });

  @DELETE("users/delete-apartment/{id}")
  @override
  Future<BaseResponse<RealEstateModel>> delete({
    @Path("id") required String id,
  });

  @PATCH("users/update-apartment/{id}")
  @override
  Future<BaseResponse<RealEstateModel>> edit({
    @Body() required RealEstateParamsModel params,
    @Path() required String id,
  });

  @POST("images/{id}/apartment")
  @override
  Future<BaseResponse<RealEstateModel>> addApartmentImage({
    @Body() required FormData form,
    @Path() required String id,
  });

  @DELETE("images/{id}/apartment")
  @override
  Future<BaseResponse<RealEstateModel>> deleteApartmentImage({
    @Path("id") required String image,
  });

  @GET("users/getApartment")
  @override
  Future<BaseResponse<List<RealEstateModel>>> getMineList({
    @Queries() required RealEstateGetParamsModel params,
  });
}
