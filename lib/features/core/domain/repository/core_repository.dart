import 'package:dartz/dartz.dart';
import 'package:real_state/features/core/domain/entity/city.dart';
import 'package:real_state/features/core/domain/entity/contact_item.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';

abstract class CoreRepository {
  Future<Either<Failure, List<ContactItem>>> getContacts();
  Future<Either<Failure, List<City>>> getCities();
}
