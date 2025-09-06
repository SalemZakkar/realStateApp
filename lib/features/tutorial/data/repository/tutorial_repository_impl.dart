import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/data/utils/api_handler.dart';
import 'package:real_state/features/core/domain/entity/failures.dart';
import 'package:real_state/features/tutorial/domain/entity/tutorial.dart';
import 'package:real_state/features/tutorial/domain/repository/tutorial_repository.dart';

@Injectable(as: TutorialRepository)
class TutorialRepositoryImpl extends TutorialRepository with ApiHandler {
  @override
  Future<Either<Failure, List<Tutorial>>> getTutorials() {
    return request(() async {
      return Right([
        Tutorial(url: "url", title: "title", image: "68bc4b5ec6ac7c75b9b852c6"),
        Tutorial(url: "url", title: "title", image: "68bc4b62c6ac7c75b9b852cd"),
        Tutorial(url: "url", title: "title", image: "68bc4b64c6ac7c75b9b852d4"),
      ]);
    });
  }
}
