import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/domain/entity/otp_status.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_state.dart';

@injectable
class AuthSendOtpPasswordCubit extends Cubit<BaseState<OtpStatus>> {
  AuthSendOtpPasswordCubit(this.authRepository) : super(BaseState());
  AuthRepository authRepository;

  void exec({required String email}) async {
    emit(state.setInProgressState());
    var res = await authRepository.requestOtpPassword(email: email);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
