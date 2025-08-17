import 'package:injectable/injectable.dart';

import '../../domain/entity/configuration.dart';
import 'app_environment.dart';

@LazySingleton(as: Configuration,)
class DevConfiguration extends Configuration {
  @override
  String get name => AppEnvironment.dev;

  @override
  String get getBaseUrl => "http://10.0.2.2:3000/api/v1/";
}