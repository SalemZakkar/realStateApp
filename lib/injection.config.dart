// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:real_state/features/auth/data/repository/auth_repository_impl.dart'
    as _i981;
import 'package:real_state/features/auth/data/source/auth_local_source/auth_local_source.dart'
    as _i837;
import 'package:real_state/features/auth/data/source/auth_remote_source/auth_remote_source.dart'
    as _i31;
import 'package:real_state/features/auth/domain/repository/auth_repository.dart'
    as _i458;
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart'
    as _i202;
import 'package:real_state/features/auth/presentation/cubits/auth_send_otp_cubit.dart'
    as _i525;
import 'package:real_state/features/auth/presentation/cubits/auth_send_otp_password.dart'
    as _i1068;
import 'package:real_state/features/auth/presentation/cubits/auth_sign_in_cubit.dart'
    as _i602;
import 'package:real_state/features/auth/presentation/cubits/auth_sign_up_cubit.dart'
    as _i296;
import 'package:real_state/features/auth/presentation/cubits/auth_verify_otp_cubit.dart'
    as _i1001;
import 'package:real_state/features/auth/presentation/cubits/auth_verify_otp_password_cubit.dart'
    as _i668;
import 'package:real_state/features/core/data/repository/core_repo_impl.dart'
    as _i1031;
import 'package:real_state/features/core/data/source/core_remote_source/core_remote_source.dart'
    as _i910;
import 'package:real_state/features/core/data/utils/configuration.dart' as _i40;
import 'package:real_state/features/core/data/utils/token_interceptor.dart'
    as _i838;
import 'package:real_state/features/core/domain/entity/configuration.dart'
    as _i780;
import 'package:real_state/features/core/domain/repository/core_repository.dart'
    as _i676;
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart'
    as _i305;
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart'
    as _i672;
import 'package:real_state/features/user/data/repository/user_repository_impl.dart'
    as _i905;
import 'package:real_state/features/user/data/source/user_remote_source/user_remote_source.dart'
    as _i797;
import 'package:real_state/features/user/domain/repository/user_repository.dart'
    as _i140;
import 'package:real_state/features/user/presentation/cubit/user_change_password_cubit.dart'
    as _i737;
import 'package:real_state/features/user/presentation/cubit/user_get_mine_cubit.dart'
    as _i509;
import 'package:real_state/features/user/presentation/cubit/user_update_cubit.dart'
    as _i16;
import 'package:real_state/injectable_module.dart' as _i162;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.factory<_i837.AuthLocalSource>(() => _i837.AuthLocalSource());
    gh.lazySingleton<_i838.TokenInterceptor>(() => _i838.TokenInterceptor());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i892.FirebaseMessaging>(
      () => injectableModule.firebaseMessaging(),
    );
    gh.lazySingleton<_i780.Configuration>(() => _i40.DevConfiguration());
    gh.factory<_i910.CoreRemoteSource>(
      () => _i910.CoreRemoteSourceImpl(
        gh<_i361.Dio>(),
        gh<_i780.Configuration>(),
      ),
    );
    gh.factory<_i676.CoreRepository>(
      () => _i1031.CoreRepoImpl(gh<_i910.CoreRemoteSource>()),
    );
    gh.lazySingleton<_i672.ContactCubit>(
      () => _i672.ContactCubit(gh<_i676.CoreRepository>()),
    );
    gh.lazySingleton<_i305.CityCubit>(
      () => _i305.CityCubit(gh<_i676.CoreRepository>()),
    );
    gh.factory<_i797.UserRemoteSource>(
      () => _i797.UserRemoteSourceImpl(
        gh<_i361.Dio>(),
        gh<_i780.Configuration>(),
      ),
    );
    gh.factory<_i31.AuthRemoteSource>(
      () => _i31.AuthRemoteImpl(gh<_i361.Dio>(), gh<_i780.Configuration>()),
    );
    gh.factory<_i140.UserRepository>(
      () => _i905.UserRepositoryImpl(gh<_i797.UserRemoteSource>()),
    );
    gh.factory<_i737.UserChangePasswordCubit>(
      () => _i737.UserChangePasswordCubit(gh<_i140.UserRepository>()),
    );
    gh.singleton<_i458.AuthRepository>(
      () => _i981.AuthRepositoryImpl(
        gh<_i837.AuthLocalSource>(),
        gh<_i31.AuthRemoteSource>(),
      ),
    );
    gh.factory<_i525.AuthSendOtpCubit>(
      () => _i525.AuthSendOtpCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i602.AuthSignInCubit>(
      () => _i602.AuthSignInCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i296.AuthSignUpCubit>(
      () => _i296.AuthSignUpCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i1001.AuthVerifyOtpCubit>(
      () => _i1001.AuthVerifyOtpCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i1068.AuthSendOtpPasswordCubit>(
      () => _i1068.AuthSendOtpPasswordCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i668.AuthVerifyOtpPasswordCubit>(
      () => _i668.AuthVerifyOtpPasswordCubit(gh<_i458.AuthRepository>()),
    );
    gh.singleton<_i202.AuthCubit>(
      () => _i202.AuthCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i509.UserGetMineCubit>(
      () => _i509.UserGetMineCubit(
        gh<_i202.AuthCubit>(),
        gh<_i140.UserRepository>(),
      ),
    );
    gh.factory<_i16.UserUpdateCubit>(
      () => _i16.UserUpdateCubit(
        gh<_i140.UserRepository>(),
        gh<_i202.AuthCubit>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i162.InjectableModule {}
