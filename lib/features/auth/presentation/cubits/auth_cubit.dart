import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:real_state/features/auth/domain/repository/auth_repository.dart';
import 'package:real_state/features/core/domain/entity/auth_state_type.dart';
import 'package:real_state/features/core/domain/entity/user_stream_signal.dart';
import 'package:real_state/features/user/data/model/user_model/user_model.dart';
import 'package:real_state/features/user/domain/entity/user.dart';

class AuthState {
  AuthStateType authState;

  AuthState({this.authState = AuthStateType.initial, this.userData});

  User? userData;

  User get user {
    if (userData == null) {
      throw Exception("UNAUTH");
    }
    return userData!;
  }

  bool get authenticated => authState == AuthStateType.authenticated;
}

@singleton
class AuthCubit extends HydratedCubit<AuthState> {
  AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthState()) {
    authRepository.authStream.listen((e) {
      emitAuthState(e);
    });
  }

  void emitAuthState(UserStreamSignal e) {
    if (e.user == null) {
      emit(AuthState(authState: AuthStateType.unAuth));
    } else if (e.user?.isEmailVerified == false) {
      // print('sss');
      emit(AuthState(authState: AuthStateType.unActivated, userData: e.user!));
    } else if (e.user?.isActive == false) {
      emit(AuthState(authState: AuthStateType.blocked, userData: e.user!));
    } else {
      emit(AuthState(authState: AuthStateType.authenticated, userData: e.user));
    }
  }

  void init() {
    emit(state);
  }

  void setUser(User? user) {
    emitAuthState(UserStreamSignal(user: user));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json == {}) {
      return AuthState();
    }
    return AuthState(
      authState: AuthStateType.fromString(json['state']),
      userData: json['user'] == null
          ? null
          : UserModel.fromJson(json['user']).toDomain(),
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return {
      "state": state.authState.getString(),
      "user": state.userData?.toData().toJson(),
    };
  }
}
