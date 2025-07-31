import 'package:real_state/features/core/data/model/base_response/base_response.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';

abstract class UserRemoteSource {
  Future<BaseResponse<UserModel>> getMine();

  Future<void> changePassword({
    required String old,
    required String password,
    required String newPassword,
  });
}

// @RestApi()
// @Injectable(as: UserRemoteSource)
// abstract class UserRemoteSourceImpl extends UserRemoteSource {
//   @factoryMethod
//   factory UserRemoteSourceImpl(Dio dio, Configuration configuration) {
//     return _UserRemoteSourceImpl(dio, baseUrl: configuration.getBaseUrl);
//   }
//
//   @override
//   Future<void> changePassword({
//     required String old,
//     required String password,
//     required String newPassword,
//   });
//
//   @override
//   Future<BaseResponse<UserModel>> getMine();
// }
