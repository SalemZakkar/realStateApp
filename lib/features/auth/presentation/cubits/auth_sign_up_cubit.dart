import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

import '../../domain/params/auth_sign_up_params.dart';

@injectable
class AuthSignUpCubit extends Cubit<BaseState<User>> {
  AuthSignUpCubit(this.authRepository) : super(BaseState());
  AuthRepository authRepository;

  void exec({required AuthSignUpParams params}) async {
    emit(state.setInProgressState());
    var res = await authRepository.register(params: params);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
