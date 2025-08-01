import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';

@injectable
class AuthVerifyOtpPasswordCubit extends Cubit<BaseState<void>> {
  AuthVerifyOtpPasswordCubit(this.authRepository) : super(BaseState());
  AuthRepository authRepository;

  void exec({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.setInProgressState());
    var res = await authRepository.verifyOtpPassword(
      confirmPassword: confirmPassword,
      password: password,
      email: email,
      code: code,
    );
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
