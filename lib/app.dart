import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/core/domain/entity/auth_state_type.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/page/splash_page.dart';
import 'package:real_state/features/core/presentation/page/verify_otp_page.dart';
import 'package:real_state/features/home/presentation/home_page.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/routing/observer_utils.dart';
import 'package:real_state/routing/route_info.dart';
import 'package:real_state/routing/routes.dart';
import 'package:real_state/themes/app_theme.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((e) {
      getIt<AuthCubit>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<AuthCubit>())],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.authState == AuthStateType.authenticated) {
                goRouterConfig.go(HomePage.path);
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
              goRouterConfig.go(AuthLoginPage.path);
            },
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: Translations.localizationsDelegates,
          supportedLocales: Translations.supportedLocales,
          theme: context.theme.appTheme.getThemeData(),
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
  );
}).toList();
