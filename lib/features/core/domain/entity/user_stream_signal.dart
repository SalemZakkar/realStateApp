import 'package:real_state/features/user/domain/entity/user.dart';

class UserStreamSignal {
  User? user;
  bool withPush;

  UserStreamSignal({this.user, required this.withPush});
}
