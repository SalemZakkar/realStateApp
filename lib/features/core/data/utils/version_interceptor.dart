import 'package:core_package/core_package.dart';
import 'package:platform_identity/platform_identity.dart';
import 'package:real_state/app.dart';
import 'package:real_state/features/core/presentation/page/update_app_page.dart';

class VersionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "x-mobile-version": PlatformIdentity.getAppVersion(),
    });
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.data['code'] == 'VERSION_NOT_SUPPORTED' &&
        err.response?.statusCode == 426) {
      goRouterConfig.go(UpdateAppPage.path);
    }
    return handler.next(err);
  }
}
