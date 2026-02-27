import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/domain/entity/auth_state_type.dart';
import 'package:real_state/features/core/domain/entity/user_stream_signal.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:real_state/features/user/domain/entity/user.dart';
import 'package:real_state/features/user/presentation/cubit/user_get_mine_cubit.dart';
import 'package:real_state/injection.dart';

class AuthState {
  AuthStateType authState;

  AuthState({
    this.authState = AuthStateType.initial,
    this.userData,
    this.withPush = false,
  });

  User? userData;

  bool withPush;

  User get user {
    if (userData == null) {
      throw Exception("UNAUTH");
    }
    return userData!;
  }

  bool get authenticated => userData != null;
}

@lazySingleton
class AuthCubit extends HydratedCubit<AuthState> {
  AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthState()) {
    authRepository.authStream.listen((e) {
      emitAuthState(e);
    });
  }

  void emitAuthState(UserStreamSignal e) {
    if (e.user == null) {
      emit(AuthState(authState: AuthStateType.unAuth, withPush: e.withPush));
    } else if (e.user?.isCompleted == false) {
      emit(
        AuthState(
          authState: AuthStateType.unActivated,
          userData: e.user!,
          withPush: e.withPush,
        ),
      );
    } else if (e.user?.isActive == false) {
      emit(
        AuthState(
          authState: AuthStateType.blocked,
          userData: e.user!,
          withPush: e.withPush,
        ),
      );
    } else {
      emit(
        AuthState(
          authState: AuthStateType.authenticated,
          userData: e.user,
          withPush: e.withPush,
        ),
      );
    }
  }

  void setUser(User? user, {bool? isPush}) {
    emitAuthState(
      UserStreamSignal(
        user: user,
        withPush: isPush ?? user?.isCompleted == false,
      ),
    );
  }

  void init() {
    emit(
      AuthState(
        withPush: true,
        userData: state.userData,
        authState: state.authState,
      ),
    );
    getIt<UserGetMineCubit>().get();
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final state = AuthState(
      authState: AuthStateType.fromString(json['state']),
      userData: json['user'] == null
          ? null
          : UserModel.fromJson(json['user']).toDomain(),
    );
    return state;
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      "state": state.authState.getString(),
      "user": state.userData?.toData().toJson(),
    };
  }
}
