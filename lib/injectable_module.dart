import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/timeout_interceptor.dart';
import 'package:real_state/features/core/data/utils/token_interceptor.dart';
import 'package:real_state/features/core/data/utils/version_interceptor.dart';
import 'package:real_state/injection.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
        headers: {'Accept': '*/*'},
        sendTimeout: Duration(seconds: 90),
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        validateStatus: (statusCode) {
          if (statusCode != null) {
            if (200 <= statusCode && statusCode < 300) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        },
      ),
    );
    dio.interceptors.addAll([
      getIt<TokenInterceptor>(),
      TimeoutInterceptor(),
      VersionInterceptor(),
      UnifiInterceptor(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        request: true,
        // usePrint: true,
      ),
    ]);

    return dio;
  }

  @lazySingleton
  Logger get logger => Logger();
}
