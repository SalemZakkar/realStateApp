import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/tutorial/domain/entity/tutorial.dart';
import 'package:real_state/features/tutorial/domain/repository/tutorial_repository.dart';

@injectable
class TutorialCubit extends Cubit<BaseState<List<Tutorial>>> {
  TutorialCubit(this.tutorialRepository) : super(BaseState());
  TutorialRepository tutorialRepository;

  void get() async {
    emit(state.setInProgressState());
    var res = await tutorialRepository.getTutorials();
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
