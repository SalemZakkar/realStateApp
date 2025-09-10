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
import 'package:real_state/features/core/data/utils/token_interceptor.dart'
    as _i838;
import 'package:real_state/features/core/domain/repository/core_repository.dart'
    as _i676;
import 'package:real_state/features/core/presentation/cubit/app_update.dart'
    as _i216;
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart'
    as _i305;
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart'
    as _i672;
import 'package:real_state/features/core/presentation/cubit/settings_cubit.dart'
    as _i568;
import 'package:real_state/features/core/presentation/utils/file_manager.dart'
    as _i976;
import 'package:real_state/features/real_state/data/repository/real_estate_repository_impl.dart'
    as _i127;
import 'package:real_state/features/real_state/data/source/real_estate_remote_source/real_estate_remote_source.dart'
    as _i521;
import 'package:real_state/features/real_state/domain/repository/real_estate_repository.dart'
    as _i670;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_add_image_cubit.dart'
    as _i860;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_create_cubit.dart'
    as _i115;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_delete_cubit.dart'
    as _i56;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_delete_image_cubit.dart'
    as _i31;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_details_cubit.dart'
    as _i200;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_edit_cubit.dart'
    as _i477;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_featured_list_cubit.dart'
    as _i643;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart'
    as _i1066;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_mine_list_cubit.dart'
    as _i966;
import 'package:real_state/features/real_state/presentation/cubit/real_estate_map_get.dart'
    as _i680;
import 'package:real_state/features/tutorial/data/repository/tutorial_repository_impl.dart'
    as _i432;
import 'package:real_state/features/tutorial/data/source/remote/tutorial_remote_source.dart'
    as _i366;
import 'package:real_state/features/tutorial/domain/repository/tutorial_repository.dart'
    as _i13;
import 'package:real_state/features/tutorial/presentation/cubit/tutorial_cubit.dart'
    as _i875;
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
    gh.singleton<_i568.SettingsCubit>(() => _i568.SettingsCubit());
    gh.singleton<_i200.RealEstateDetailsCubit>(
      () => _i200.RealEstateDetailsCubit(),
    );
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
    gh.factory<_i521.RealEstateRemoteSource>(
      () => _i521.RealEstateRemoteSourceImpl(
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
    gh.factory<_i366.TutorialRemoteSource>(
      () => _i366.TutorialRemoteSourceImpl(
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
    gh.singleton<_i676.CoreRepository>(
      () => _i1031.CoreRepoImpl(gh<_i910.CoreRemoteSource>()),
    );
    gh.factory<_i670.RealEstateRepository>(
      () => _i127.RealEstateRepositoryImpl(gh<_i521.RealEstateRemoteSource>()),
    );
    gh.lazySingleton<_i305.CityCubit>(
      () => _i305.CityCubit(gh<_i676.CoreRepository>()),
    );
    gh.lazySingleton<_i672.ContactCubit>(
      () => _i672.ContactCubit(gh<_i676.CoreRepository>()),
    );
    gh.singleton<_i216.AppUpdateCubit>(
      () => _i216.AppUpdateCubit(gh<_i676.CoreRepository>()),
    );
    gh.factory<_i13.TutorialRepository>(
      () => _i432.TutorialRepositoryImpl(gh<_i366.TutorialRemoteSource>()),
    );
    gh.factory<_i140.UserRepository>(
      () => _i905.UserRepositoryImpl(gh<_i797.UserRemoteSource>()),
    );
    gh.singleton<_i422.AdBannerCubit>(
      () => _i422.AdBannerCubit(gh<_i593.AdBannerRepository>()),
    );
    gh.factory<_i737.UserChangePasswordCubit>(
      () => _i737.UserChangePasswordCubit(gh<_i140.UserRepository>()),
    );
    gh.factory<_i525.AuthSendOtpCubit>(
      () => _i525.AuthSendOtpCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i1068.AuthSendOtpPasswordCubit>(
      () => _i1068.AuthSendOtpPasswordCubit(gh<_i458.AuthRepository>()),
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
    gh.factory<_i668.AuthVerifyOtpPasswordCubit>(
      () => _i668.AuthVerifyOtpPasswordCubit(gh<_i458.AuthRepository>()),
    );
    gh.lazySingleton<_i202.AuthCubit>(
      () => _i202.AuthCubit(gh<_i458.AuthRepository>()),
    );
    gh.factory<_i875.TutorialCubit>(
      () => _i875.TutorialCubit(gh<_i13.TutorialRepository>()),
    );
    gh.factory<_i509.UserGetMineCubit>(
      () => _i509.UserGetMineCubit(
        gh<_i202.AuthCubit>(),
        gh<_i140.UserRepository>(),
      ),
    );
    gh.factory<_i860.RealEstateAddImageCubit>(
      () => _i860.RealEstateAddImageCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.factory<_i115.RealEstateCreateCubit>(
      () => _i115.RealEstateCreateCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.factory<_i56.RealEstateDeleteCubit>(
      () => _i56.RealEstateDeleteCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.factory<_i31.RealEstateDeleteImageCubit>(
      () => _i31.RealEstateDeleteImageCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.factory<_i477.RealEstateEditCubit>(
      () => _i477.RealEstateEditCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.factory<_i643.RealEstateFeaturedListCubit>(
      () => _i643.RealEstateFeaturedListCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.factory<_i680.RealEstateMapGetCubit>(
      () => _i680.RealEstateMapGetCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.singleton<_i1066.RealEstateGetListCubit>(
      () => _i1066.RealEstateGetListCubit(gh<_i670.RealEstateRepository>()),
    );
    gh.singleton<_i966.RealEstateGetMineListCubit>(
      () => _i966.RealEstateGetMineListCubit(gh<_i670.RealEstateRepository>()),
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
