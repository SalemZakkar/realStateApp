import 'dart:async';

import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/source/core_remote_source/core_remote_source.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/app_state.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/entity/contact_item.dart';
import 'package:real_state/features/core/domain/entity/legal.dart';
import 'package:real_state/features/core/domain/repository/core_repository.dart';

@Singleton(as: CoreRepository)
class CoreRepoImpl extends CoreRepository with ApiHandler {
  CoreRemoteSource source;

  CoreRepoImpl(this.source);

  StreamController<AppUpdateState> controller = StreamController.broadcast();

  @override
  Future<Either<Failure, List<City>>> getCities() {
    return request(() async {
      var res = await source.getCities();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }

  @override
  Future<Either<Failure, List<ContactItem>>> getContacts() {
    return request(() async {
      // return Right([
      //   ContactItem(type: ContactType.whatsapp, value: 'value' , title: 'whatsapp'),
      //   ContactItem(type: ContactType.whatsapp, value: 'value' , title: 'whatsapp'),
      //   ContactItem(type: ContactType.whatsapp, value: 'value' , title: 'whatsapp'),
      //   ContactItem(type: ContactType.whatsapp, value: 'value' , title: 'whatsapp'),
      // ]);
      var res = await source.getContacts();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }

  @override
  void addAppStatus(AppUpdateState appStatus) {
    controller.add(appStatus);
  }

  @override
  Stream<AppUpdateState> get appStatus => controller.stream;

  @override
  Future<Either<Failure, Legal>> getLegals() {
    return request(() async {
      var res = await source.getLegal();
      return Right(
        Legal(
          privacyPolicy: res.data['privacyPolicy'],
          termsAndConditions: res.data['termsAndConditions'],
        ),
      );
    });
  }
}
