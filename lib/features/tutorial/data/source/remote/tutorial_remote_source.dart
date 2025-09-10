import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/configuration.dart';
import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/tutorial/data/model/tutorial_model/tutorial_model.dart';
import 'package:retrofit/retrofit.dart';

part 'tutorial_remote_source.g.dart';

abstract class TutorialRemoteSource {
  Future<BaseResponse<List<TutorialModel>>> getTutorials();
}

@RestApi()
@Injectable(as: TutorialRemoteSource)
abstract class TutorialRemoteSourceImpl extends TutorialRemoteSource {
  @factoryMethod
  factory TutorialRemoteSourceImpl(Dio dio, Configuration configuration) {
    return _TutorialRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
  }

  @GET("helpUser")
  @override
  Future<BaseResponse<List<TutorialModel>>> getTutorials();
}
