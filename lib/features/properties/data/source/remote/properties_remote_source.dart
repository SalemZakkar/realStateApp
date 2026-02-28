import 'package:real_state/configuration.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/properties/data/model/property_get_params_model/property_get_params_model.dart';
import 'package:real_state/features/properties/data/model/property_model/property_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

part 'properties_remote_source.g.dart';

abstract class PropertiesRemoteSource {
  Future<BaseResponse<List<PropertyModel>>> getProperty(
    PropertyGetParamsModel params,
  );

  Future<BaseResponse<PropertyModel>> getById(String id);
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
}
