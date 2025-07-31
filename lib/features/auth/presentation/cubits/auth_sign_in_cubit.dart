import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/params/auth_sign_in_params.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

@injectable
class AuthSignInCubit extends Cubit<BaseState<User>> {
  AuthSignInCubit(this.authRepository) : super(BaseState());
  AuthRepository authRepository;

  void exec({required AuthSignInParams params}) async {
    emit(state.setInProgressState());
    var res = await authRepository.login(params: params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
