import 'package:dio/dio.dart';
import 'package:platform_identity/platform_identity.dart';
import 'package:real_state/features/core/domain/entity/app_state.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';
import 'package:real_state/injection.dart';

class VersionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"appversion": PlatformIdentity.getAppVersion()});
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.data['code'] == 'UPDATE' &&
        err.response?.statusCode == 426) {
      getIt<CoreRepository>().addAppStatus(OutdatedAppState());
    }
    return handler.next(err);
  }
}
