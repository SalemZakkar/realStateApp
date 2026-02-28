// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:real_state/configuration.dart' as _i270;
import 'package:real_state/features/ad_banner/data/repository/ad_banner_repo_impl.dart'
    as _i579;
import 'package:real_state/features/ad_banner/data/source/remote/ad_banner_remote_source.dart'
    as _i534;
import 'package:real_state/features/ad_banner/domain/repository/ad_banner_repository.dart'
    as _i593;
import 'package:real_state/features/ad_banner/presentation/cubit/ad_banner_cubit.dart'
    as _i422;
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
import 'package:real_state/features/auth/presentation/cubits/auth_login_otp.dart'
    as _i204;
import 'package:real_state/features/auth/presentation/cubits/auth_otp_cubit.dart'
    as _i553;
import 'package:real_state/features/core/data/repository/core_repo_impl.dart'
    as _i1031;
import 'package:real_state/features/core/data/source/core_remote_source/core_remote_source.dart'
    as _i910;
import 'package:real_state/features/core/data/utils/token_interceptor.dart'
    as _i838;
import 'package:real_state/features/core/domain/repository/core_repository.dart'
    as _i676;
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart'
    as _i305;
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart'
    as _i672;
import 'package:real_state/features/core/presentation/cubit/settings_cubit.dart'
    as _i568;
import 'package:real_state/features/core/presentation/utils/file_manager.dart'
    as _i976;
import 'package:real_state/features/properties/data/repository/property_repo_impl.dart'
    as _i50;
import 'package:real_state/features/properties/data/source/remote/properties_remote_source.dart'
    as _i422;
import 'package:real_state/features/properties/domain/repository/property_repository.dart'
    as _i986;
import 'package:real_state/features/properties/presentation/cubits/properties_details_cubit.dart'
    as _i17;
import 'package:real_state/features/properties/presentation/cubits/properties_get_list_cubit.dart'
    as _i865;
import 'package:real_state/features/user/data/repository/user_repository_impl.dart'
    as _i905;
import 'package:real_state/features/user/data/source/user_remote_source/user_remote_source.dart'
    as _i797;
import 'package:real_state/features/user/domain/repository/user_repository.dart'
    as _i140;
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
    gh.singleton<_i568.SettingsCubit>(() => _i568.SettingsCubit());
    gh.lazySingleton<_i838.TokenInterceptor>(() => _i838.TokenInterceptor());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i974.Logger>(() => injectableModule.logger);
    gh.lazySingleton<_i270.Configuration>(() => _i270.DevConfiguration());
    gh.singleton<_i976.FileManager>(
      () => _i976.FileManager(gh<_i270.Configuration>()),
    );
    gh.factory<_i910.CoreRemoteSource>(
      () => _i910.CoreRemoteSourceImpl(
        gh<_i361.Dio>(),
        gh<_i270.Configuration>(),
      ),
    );
    gh.factory<_i31.AuthRemoteSource>(
      () => _i31.AuthRemoteImpl(gh<_i361.Dio>(), gh<_i270.Configuration>()),
    );
    gh.factory<_i797.UserRemoteSource>(
      () => _i797.UserRemoteSourceImpl(
        gh<_i361.Dio>(),
        gh<_i270.Configuration>(),
      ),
    );
    gh.factory<_i534.AdBannerRemoteSource>(
      () => _i534.AdBannerRemoteSourceImpl(
        gh<_i361.Dio>(),
        gh<_i270.Configuration>(),
      ),
    );
    gh.factory<_i593.AdBannerRepository>(
      () => _i579.AdBannerRepoImpl(gh<_i534.AdBannerRemoteSource>()),
    );
    gh.singleton<_i458.AuthRepository>(
      () => _i981.AuthRepositoryImpl(
        gh<_i837.AuthLocalSource>(),
        gh<_i31.AuthRemoteSource>(),
      ),
    );
    gh.factory<_i422.PropertiesRemoteSource>(
      () => _i422.PropertiesRemoteSourceImpl(
        gh<_i361.Dio>(),
        gh<_i270.Configuration>(),
      ),
    );
    gh.singleton<_i986.PropertiesRepository>(
      () => _i50.PropertiesRepoImpl(gh<_i422.PropertiesRemoteSource>()),
    );
    gh.singleton<_i676.CoreRepository>(
      () => _i1031.CoreRepoImpl(gh<_i910.CoreRemoteSource>()),
    );
    gh.lazySingleton<_i305.CityCubit>(
      () => _i305.CityCubit(gh<_i676.CoreRepository>()),
    );
    gh.lazySingleton<_i672.AboutUsCubit>(
      () => _i672.AboutUsCubit(gh<_i676.CoreRepository>()),
    );
    gh.factory<_i140.UserRepository>(
      () => _i905.UserRepositoryImpl(gh<_i797.UserRemoteSource>()),
    );
    gh.factory<_i17.PropertiesDetailsCubit>(
      () => _i17.PropertiesDetailsCubit(gh<_i986.PropertiesRepository>()),
    );
    gh.factory<_i865.PropertiesGetListCubit>(
      () => _i865.PropertiesGetListCubit(gh<_i986.PropertiesRepository>()),
    );
    gh.singleton<_i422.AdBannerCubit>(
      () => _i422.AdBannerCubit(gh<_i593.AdBannerRepository>()),
    );
    gh.factory<_i204.AuthLoginCubit>(
      () => _i204.AuthLoginCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i553.AuthOtpCubit>(
      () => _i553.AuthOtpCubit(gh<_i458.AuthRepository>()),
    );
    gh.lazySingleton<_i202.AuthCubit>(
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
