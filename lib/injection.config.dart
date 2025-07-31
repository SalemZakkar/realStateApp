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
import 'package:real_state/features/auth/presentation/cubits/auth_sign_in_cubit.dart'
    as _i602;
import 'package:real_state/features/auth/presentation/cubits/auth_sign_up_cubit.dart'
    as _i296;
import 'package:real_state/features/auth/presentation/cubits/auth_verify_otp_cubit.dart'
    as _i1001;
import 'package:real_state/features/core/data/utils/configuration.dart' as _i40;
import 'package:real_state/features/core/data/utils/token_interceptor.dart'
    as _i838;
import 'package:real_state/features/core/domain/entity/configuration.dart'
    as _i780;
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
    gh.factory<_i31.AuthRemoteSource>(
      () => _i31.AuthRemoteImpl(gh<_i361.Dio>(), gh<_i780.Configuration>()),
    );
    gh.singleton<_i458.AuthRepository>(
      () => _i981.AuthRepositoryImpl(
        gh<_i837.AuthLocalSource>(),
        gh<_i31.AuthRemoteSource>(),
      ),
    );
    gh.factory<_i602.AuthSignInCubit>(
      () => _i602.AuthSignInCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i296.AuthSignUpCubit>(
      () => _i296.AuthSignUpCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i525.AuthSendOtpCubit>(
      () => _i525.AuthSendOtpCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i1001.AuthVerifyOtpCubit>(
      () => _i1001.AuthVerifyOtpCubit(gh<_i458.AuthRepository>()),
    );
    gh.singleton<_i202.AuthCubit>(
      () => _i202.AuthCubit(gh<_i458.AuthRepository>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i162.InjectableModule {}
