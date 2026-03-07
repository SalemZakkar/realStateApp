import 'package:core_package/core_package.dart';

class TimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains("video")) {
      options.sendTimeout = null;
    }
    super.onRequest(options, handler);
  }
}
