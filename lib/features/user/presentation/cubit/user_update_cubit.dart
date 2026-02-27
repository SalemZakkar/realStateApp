import 'package:core_package/core_package.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/domain/params/user_update_params.dart';
import 'package:real_state/features/user/domain/repository/user_repository.dart';

@injectable
class UserUpdateCubit extends Cubit<BaseState<User>> {
  final UserRepository repository;
  final AuthCubit authCubit;

  UserUpdateCubit(this.repository, this.authCubit) : super(BaseState());

  void change(UserUpdateParams params) async {
    emit(state.setInProgressState());
    var res = params.deleteImage == true
        ? await repository.deletePhoto()
        : await repository.updateUser(params: params);
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      authCubit.setUser(r);
      emit(state.setSuccessState(r));
    });
  }

  void complete(UserUpdateParams params) async {
    emit(state.setInProgressState());
    var res = params.deleteImage == true
        ? await repository.deletePhoto()
        : await repository.updateUser(params: params);
    res.fold((e) => emit(state.setFailureState(e)), (r) {
      authCubit.setUser(r, isPush: r.isCompleted);
      emit(state.setSuccessState(r));
    });
  }
}
