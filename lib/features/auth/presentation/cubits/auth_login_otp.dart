import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';

@injectable
class AuthLoginCubit extends Cubit<BaseState> {
  AuthRepository authRepository;

  AuthLoginCubit(this.authRepository) : super(BaseState());

  void login({required String vid, required String code}) async {
    emit(state.setInProgressState());
    var res = await authRepository.login(vid, code);
    res.fold(
      (e) => emit(state.setFailureState(e)),
      (r) => emit(state.setSuccessState(null)),
    );
  }
}
