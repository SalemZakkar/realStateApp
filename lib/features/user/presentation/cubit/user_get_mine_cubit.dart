import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/repository/user_repository.dart';

@injectable
class UserGetMineCubit extends Cubit<BaseState<User>> {
  final AuthCubit authCubit;
  final UserRepository repository;

  UserGetMineCubit(this.authCubit, this.repository) : super(BaseState());

  void get() async {
    emit(state.setInProgressState());
    var res = await repository.getMine();
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      authCubit.setUser(r);
      emit(state.setSuccessState(r));
    });
  }
}
