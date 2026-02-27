import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/entity/auth_otp.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';

@injectable
class AuthOtpCubit extends Cubit<BaseState<AuthOtp>> {
  AuthRepository authRepository;

  AuthOtpCubit(this.authRepository) : super(BaseState());

  void request({required String phone}) async {
    emit(state.setInProgressState());
    var res = await authRepository.requestOtp(phone);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(r)),
    );
  }
}
