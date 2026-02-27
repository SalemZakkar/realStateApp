import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:real_state/features/core/data/utils/token_interceptor.dart';
import 'package:real_state/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/core/data/utils/unifi_logger.dart';
import 'features/core/data/utils/version_interceptor.dart';

@module
abstract class InjectableModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dioInstance {
    final dio = Dio(
      BaseOptions(
        headers: {'Accept': '*/*'},
        sendTimeout: Duration(seconds: 30),
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
