import 'package:injectable/injectable.dart';
import 'package:real_state/injection.dart';

@Singleton()
class PropertyCacheSource {
  Map<String, bool> savedCacheTable = {};

  void save(String id) {
    savedCacheTable[id] = true;
  }

  void unSave(String id) {
    savedCacheTable[id] = false;
  }

  bool saved(String id) => savedCacheTable[id] ?? false;

  static dynamic propertyFromJson(dynamic json) {
    return getIt<PropertyCacheSource>().savedCacheTable[json['id']] ??
        json['isSaved'] ??
        false;
  }
}
