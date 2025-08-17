import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/data/source/auth_local_source/auth_local_source.dart';

import '../../../../injection.dart';

@lazySingleton
class TokenInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Map<String, String> headers = {'appversion' : '0.0.8'};
    final login = await getIt<AuthLocalSource>().getToken();
    if (login != null) {
      headers = {'Authorization': 'Bearer $login' ,};
    }
    options.headers.addAll(headers);

    return handler.next(options);
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
