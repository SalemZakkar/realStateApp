import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/domain/entity/configuration.dart';

@singleton
class FileManager {
  Configuration configuration;

  FileManager(this.configuration);

  String? getFile({String? name, required String prefix}) {
    if (name == null) {
      return null;
    }
    return "${configuration.getBaseUrl}$prefix/$name";
  }

  String? getApartment({String? name}) {
    return getFile(name: name, prefix: "apartment");
  }
}
