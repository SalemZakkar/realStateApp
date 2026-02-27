
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/data/source/auth_local_source/auth_local_source.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';

import '../../../../injection.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Map<String, String> headers = {};
    final login = await getIt<AuthLocalSource>().getToken();
    if (login != null) {
      headers = {'Authorization': 'Bearer $login'};
    }
    options.headers.addAll(headers);

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.data['message'] == "UnAuthenticated") {
      var oldToken = await getIt<AuthLocalSource>().getToken();
      if (oldToken == null) {
        return handler.next(err);
      }
      var res = await getIt<AuthRepository>().refreshToken();
      if (res.isLeft()) {
        return handler.next(err);
      }
      try {
        var k = await getIt<AuthLocalSource>().getToken();
        err.requestOptions.headers['Authorization'] =
            "Bearer $k";
        if (err.requestOptions.data is FormData) {
          err.requestOptions.data = copyFormData(err.requestOptions.data);
        }

        var n = await getIt<Dio>().fetch(err.requestOptions);
        return handler.resolve(n);
      } catch (e) {
        return handler.next(err);
      }
    }
    if (err.response?.data['message'] == 'Refresh Token Expired' ||
        err.response?.data['message'] == 'Invalid Token') {
      getIt<AuthRepository>().logout();
    }
    return handler.next(err);
  }

  FormData copyFormData(FormData original) {
    FormData newFormData = FormData();

    for (var field in original.fields) {
      newFormData.fields.add(MapEntry(field.key, field.value));
    }

    for (var file in original.files) {
      newFormData.files.add(MapEntry(file.key, file.value.clone()));
    }

    return newFormData;
  }
}
