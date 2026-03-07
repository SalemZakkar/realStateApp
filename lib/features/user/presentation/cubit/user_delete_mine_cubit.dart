import 'package:core_package/core_package.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/user/domain/repository/user_repository.dart';

@injectable
class UserDeleteMineCubit extends Cubit<BaseState<void>> {
  final UserRepository repository;

  UserDeleteMineCubit(this.repository) : super(BaseState());

  void delete() async {
    emit(state.setInProgressState());
    var res = await repository.deleteMyAccount();
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      emit(state.setSuccessState(null));
    });
  }
}
