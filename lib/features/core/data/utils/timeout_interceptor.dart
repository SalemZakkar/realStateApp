import 'package:core_package/core_package.dart';

class TimeoutInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains("image")) {
      options.sendTimeout = Duration(seconds: 90);
    }
    if (options.path.contains("video")) {
      options.sendTimeout = Duration(seconds: 360);
    }
    super.onRequest(options, handler);
  }
}
