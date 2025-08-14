import 'package:injectable/injectable.dart';

import '../../domain/entity/configuration.dart';
import 'app_environment.dart';

@LazySingleton(as: Configuration,)
class DevConfiguration extends Configuration {
  @override
  String get name => AppEnvironment.dev;

  @override
  String get getBaseUrl => "http://192.168.43.25:8080/api/v1/";
}