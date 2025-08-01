import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/core/data/model/contact_item_model/contact_item_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/domain/entity/configuration.dart';

part 'core_remote_source.g.dart';

abstract class CoreRemoteSource {
  Future<BaseResponse<List<ContactItemModel>>> getContacts();
}

@RestApi()
@Injectable(as: CoreRemoteSource)
abstract class CoreRemoteSourceImpl extends CoreRemoteSource {
  @factoryMethod
  factory CoreRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _CoreRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @GET("contact-info")
  @override
  Future<BaseResponse<List<ContactItemModel>>> getContacts();
}
