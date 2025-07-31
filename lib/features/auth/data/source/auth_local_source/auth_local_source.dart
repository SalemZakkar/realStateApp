import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthLocalSource {
  Future<void> setToken(String token) async {
    var b = await Hive.openBox("auth");
    await b.put("token", token);
  }

  Future<String?> getToken() async {
    var b = await Hive.openBox("auth");
    return b.get("token");
  }

  Future<void> clear() async {
    var b = await Hive.openBox("auth");
    await b.clear();
  }
}
