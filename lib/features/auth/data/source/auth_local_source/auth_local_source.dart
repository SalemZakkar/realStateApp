import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthLocalSource {
  Future<String?> getToken() async {
    var b = await Hive.openBox("auth");
    return b.get("token");
  }

  Future<String?> getRefToken() async {
    var b = await Hive.openBox("auth");
    return b.get("refToken");
  }

  Future<String?> getId() async {
    var b = await Hive.openBox("auth");
    return b.get("id");
  }

  Future<void> clear() async {
    var b = await Hive.openBox("auth");
    await b.clear();
  }

  Future<void> setTokens({required String token, String? refToken}) async {
    var b = await Hive.openBox("auth");
    await b.put("token", token);
    await b.put("refToken", refToken);
  }

  Future<void> setId(String id) async {
    var b = await Hive.openBox("auth");
    await b.put("id", id);
  }
}
