import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/user/domain/repository/user_repository.dart';

@injectable
class UserChangePasswordCubit extends Cubit<BaseState<void>> {
  final UserRepository repository;

  UserChangePasswordCubit(this.repository) : super(BaseState());

  void change({required String old, required String password}) async {
    emit(state.setInProgressState());
    var res = await repository.changePassword(
      old: old,
      password: password,
      newPassword: password,
    );
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      emit(state.setSuccessState(r));
    });
  }
}
