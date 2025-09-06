import 'package:dartz/dartz.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/tutorial/domain/entity/tutorial.dart';

abstract class TutorialRepository {
  Future<Either<Failure , List<Tutorial>>> getTutorials();
}