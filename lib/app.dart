import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/core/domain/entity/auth_state_type.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/page/update_app_page.dart';
import 'package:real_state/features/core/presentation/page/verify_otp_page.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/routing/observer_utils.dart';
import 'package:real_state/routing/route_info.dart';
import 'package:real_state/routing/routes.dart';
import 'package:real_state/themes/app_theme.dart';

import 'features/core/domain/entity/app_state.dart';
import 'features/core/presentation/cubit/app_update.dart' show AppUpdateCubit;
import 'features/core/presentation/page/splash_page.dart';
import 'generated/translation/translations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((e){
      statusCubit.init();

    });
  }

  var statusCubit = getIt<AppUpdateCubit>();

  var authCubit =  getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => authCubit,)],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AppUpdateCubit, AppUpdateState>(
            bloc: statusCubit,
            listener: (context, state) {
              if (state is NormalAppState) {
                getIt<AuthCubit>().init();
              }
              if (state is OutdatedAppState) {
                goRouterConfig.go(UpdateAppPage.path);
              }
            },
          ),
          BlocListener<AuthCubit, AuthState>(
            bloc: authCubit,
            listener: (context, state) {
              if (statusCubit.state is OutdatedAppState) {
                return;
              }
              if (state.authState == AuthStateType.unActivated) {
                goRouterConfig.go(
                  VerifyOtpPage.path,
                  extra: VerifyOtpPageParams(
                    reason: OtpReason.email,
                    email: state.user.email,
                  ),
                );
                return;
              }
              if (goRouterConfig.state.path != SplashPage.path) {
                return;
              }
              goRouterConfig.go(HomePage.path);
            },
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: Translations.localizationsDelegates,
          supportedLocales: Translations.supportedLocales,
          theme: context.theme,
          locale: Locale('ar'),
          debugShowCheckedModeBanner: false,
          routerConfig: goRouterConfig,
          builder: (context, child) {
            return Builder(
              builder: (context) {
                if (child == null) {
                  return const SizedBox();
                }
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: SafeArea(
                    top: false,
                    left: false,
                    right: false,
                    child: child,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter goRouterConfig = GoRouter(
  observers: [ObserverUtils.routeObserver],
  initialLocation: SplashPage.path,
  navigatorKey: _rootNavigatorKey,
  routes: _getRoutes(Routes.I.routes),
);

List<RouteBase> _getRoutes(List<RouteInfo>? routes) => (routes ?? []).map((
  subRoute,
) {
  if (subRoute.type == RouteType.shell) {
    return ShellRoute(
      builder: (context, state, child) =>
          subRoute.builder(context, state, child),
      routes: _getRoutes(subRoute.routes),
    );
  }
  return GoRoute(
    parentNavigatorKey: subRoute.useRootNavigator ? _rootNavigatorKey : null,
    path: subRoute.path!,
    name: subRoute.name ?? subRoute.path,
    builder: (context, state) => subRoute.builder(context, state, null),
    routes: _getRoutes(subRoute.routes),
    pageBuilder: tabRoutes.contains(subRoute.path)
        ? (context, state) =>
              NoTransitionPage(child: subRoute.builder(context, state, null))
        : null,
  );
}).toList();
