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
  String get getBaseUrl => "http://10.0.2.2:3000/api/";
  // String get getBaseUrl => "https://real-estate-api-lnn0.onrender.com/api/";
}