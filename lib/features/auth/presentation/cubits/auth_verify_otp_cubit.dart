import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

@injectable
class AuthVerifyOtpCubit extends Cubit<BaseState<User>> {
  AuthVerifyOtpCubit(this.authRepository) : super(BaseState());
  AuthRepository authRepository;

  void exec({required String code}) async {
    emit(state.setInProgressState());
    var res = await authRepository.verifyUser(code: code);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
