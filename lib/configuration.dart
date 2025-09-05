import 'package:injectable/injectable.dart';

import 'features/core/data/utils/app_environment.dart';

abstract class Configuration {
  String get name;

  String get getBaseUrl;
}

@LazySingleton(as: Configuration,)
class DevConfiguration extends Configuration {
  @override
  String get name => AppEnvironment.dev;

  @override
  String get getBaseUrl => "http://192.168.1.106:8080/api/v1/";
}