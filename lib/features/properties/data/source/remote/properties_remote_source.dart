import 'package:core_package/core_package.dart';
import 'package:real_state/configuration.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/properties/data/model/property_add_edit_params_model/property_add_edit_params_model.dart';
import 'package:real_state/features/properties/data/model/property_get_params_model/property_get_params_model.dart';
import 'package:real_state/features/properties/data/model/property_map_params_model/property_map_params_model.dart';
import 'package:real_state/features/properties/data/model/property_model/property_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'properties_remote_source.g.dart';

abstract class PropertiesRemoteSource {
  Future<BaseResponse<List<PropertyModel>>> getProperty(
    PropertyGetParamsModel params,
  );

  Future<BaseResponse<PropertyModel>> getById(String id);

  Future delete(String id);

  Future<BaseResponse<PropertyModel>> create(PropertyAddEditParamsModel params);

  Future<BaseResponse<PropertyModel>> edit(
    String id,
    PropertyAddEditParamsModel params,
  );

  Future<BaseResponse<PropertyModel>> changeStatus(String id, String status);

  Future<BaseResponse<PropertyModel>> addImage(String id, FormData data);

  Future<BaseResponse<PropertyModel>> video(String id, FormData data);

  Future<BaseResponse<PropertyModel>> deleteVideo(String id, String fileId);

  Future<BaseResponse<PropertyModel>> deleteImage(String id, String fileId);

  Future save(String id);

  Future unSave(String id);

  Future<BaseResponse<List<PropertyModel>>> getMap(
    PropertyMapParamsModel params,
  );
}

@RestApi()
@Injectable(as: PropertiesRemoteSource)
abstract class PropertiesRemoteSourceImpl extends PropertiesRemoteSource {
  @factoryMethod
  factory PropertiesRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _PropertiesRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @GET("property/{id}")
  @override
  Future<BaseResponse<PropertyModel>> getById(@Path() String id);

  @GET("property")
  @override
  Future<BaseResponse<List<PropertyModel>>> getProperty(
    @Queries() PropertyGetParamsModel params,
  );

  @POST("property/{id}/images")
  @override
  Future<BaseResponse<PropertyModel>> addImage(
    @Path() String id,
    @Body() FormData data,
  );

  @POST("property/{id}/status")
  @override
  Future<BaseResponse<PropertyModel>> changeStatus(
    @Path() String id,
    @Field() String status,
  );

  @POST("property")
  @override
  Future<BaseResponse<PropertyModel>> create(
    @Body() PropertyAddEditParamsModel params,
  );

  @DELETE("property/{id}")
  @override
  Future<dynamic> delete(@Path() String id);

  @DELETE("property/{id}/images/{fileId}")
  @override
  Future<BaseResponse<PropertyModel>> deleteImage(
    @Path() String id,
    @Path() String fileId,
  );

  @DELETE("property/{id}/video/{fileId}")
  @override
  Future<BaseResponse<PropertyModel>> deleteVideo(
    @Path() String id,
    @Path() String fileId,
  );

  @PATCH("property/{id}")
  @override
  Future<BaseResponse<PropertyModel>> edit(
    @Path() String id,
    @Body() PropertyAddEditParamsModel params,
  );

  @POST("property/{id}/video")
  @override
  Future<BaseResponse<PropertyModel>> video(
    @Path() String id,
    @Body() FormData data,
  );

  @POST("property/{id}/save")
  @override
  Future<dynamic> save(@Path() String id);

  @DELETE("property/{id}/save")
  @override
  Future<dynamic> unSave(@Path() String id);

  @GET("property/map")
  @override
  Future<BaseResponse<List<PropertyModel>>> getMap(
    @Queries() PropertyMapParamsModel params,
  );
}
