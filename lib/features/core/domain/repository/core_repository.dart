import 'package:core_package/core_package.dart';
import 'package:real_state/features/core/domain/entity/about_us.dart';
import 'package:real_state/features/core/domain/entity/city.dart';

abstract class CoreRepository {
  Future<Either<Failure, AboutUs>> getAboutUs();

  Future<Either<Failure, List<City>>> getCities();

}
