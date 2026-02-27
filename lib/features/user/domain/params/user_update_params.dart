import 'package:core_package/core_package.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

class UserUpdateParams {
  String? name;
  PickFile? image;
  final bool? deleteImage;

  factory UserUpdateParams.fromUser(User user) {
    return UserUpdateParams(name: user.name );
  }

  UserUpdateParams({this.name , this.image,this.deleteImage,});
}
