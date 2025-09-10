import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/tutorial/data/source/remote/tutorial_remote_source.dart';
import 'package:real_state/features/tutorial/domain/entity/tutorial.dart';
import 'package:real_state/features/tutorial/domain/repository/tutorial_repository.dart';

@Injectable(as: TutorialRepository)
class TutorialRepositoryImpl extends TutorialRepository with ApiHandler {
  TutorialRemoteSource source;

  TutorialRepositoryImpl(this.source);

  @override
  Future<Either<Failure, List<Tutorial>>> getTutorials() {
    return request(() async {
      var res = await source.getTutorials();
      return Right(res.data!.map((e) => e.toDomain()).toList());
    });
  }
}
