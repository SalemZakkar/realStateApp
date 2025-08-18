import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/domain/entity/configuration.dart';

@singleton
class FileManager {
  Configuration configuration;

  FileManager(this.configuration);

  String? getFile({String? name}) {
    if (name == null) {
      return null;
    }
    // print("${configuration.getBaseUrl.split("api/v1").first}$name");
    return "${configuration.getBaseUrl.split("api/v1").first}$name";
  }
}
