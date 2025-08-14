import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/auth/presentation/page/auth_signup_page.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/page/send_otp_page.dart';
import 'package:real_state/features/core/presentation/page/settings_page.dart';
import 'package:real_state/features/core/presentation/page/splash_page.dart';
import 'package:real_state/features/core/presentation/page/verify_otp_page.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_map_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_saved_page.dart';
import 'package:real_state/features/user/presentation/page/user_change_password_page.dart';
import 'package:real_state/routing/route_info.dart';

import '../features/real_state/presentation/page/real_state_list_page.dart';

class Routes {
  Routes._();

  static Routes I = Routes._();

  final List<RouteInfo> routes = [
    RouteInfo(
      path: SplashPage.path,
      builder: (context, state, child) => SplashPage(),
    ),
    RouteInfo(
      path: HomePage.path,
      type: RouteType.shell,
      builder: (co, st, child) => HomePage(child: child!),
      routes: [
        RouteInfo(
          useRootNavigator: false,
          path: RealStateMapPage.path,
          builder: (context, state, child) => RealStateMapPage(),
        ),
        RouteInfo(
          useRootNavigator: false,
          path: RealStateListPage.path,
          builder: (context, state, child) => RealStateListPage(),
        ),
        RouteInfo(
          useRootNavigator: false,
          path: RealStateSavedPage.path,
          builder: (context, state, child) => RealStateSavedPage(),
        ),
        RouteInfo(
          useRootNavigator: false,
          path: SettingsPage.path,
          builder: (context, state, child) => SettingsPage(),
        ),
      ],
    ),
    RouteInfo(
      path: AuthLoginPage.path,
      builder: (context, state, child) => AuthLoginPage(),
    ),
    RouteInfo(
      path: AuthSignUpPage.path,
      builder: (context, state, child) => AuthSignUpPage(),
    ),
    RouteInfo(
      path: SendOtpPage.path,
      builder: (context, state, child) =>
          SendOtpPage(reason: state.extra as OtpReason),
    ),
    RouteInfo(
      path: VerifyOtpPage.path,
      builder: (context, state, child) =>
          VerifyOtpPage(params: state.extra as VerifyOtpPageParams),
    ),
    RouteInfo(
      path: UserChangePasswordPage.path,
      builder: (context, state, child) => UserChangePasswordPage(),
    ),
    RouteInfo(
      path: RealEstateDetailsPage.path,
      builder: (context, state, child) => RealEstateDetailsPage(
        realEstate: state.extra as RealEstate,
      ),
    ),
    RouteInfo(
      path: MapPage.path,
      builder: (context, state, child) => MapPage(latLng: state.extra as LatLng),
    ),
  ];
}

extension R on BuildContext {
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String name, {
    required String until,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    while (GoRouter.of(this).state.name != until) {
      GoRouter.of(this).pop();
    }
    return GoRouter.of(this).pushNamed<T>(
      name,
      extra: extra,
      queryParameters: queryParameters,
      pathParameters: pathParameters,
    );
  }
}

List<String> tabRoutes = [
  RealStateListPage.path,
  RealStateMapPage.path,
  RealStateSavedPage.path,
  SettingsPage.path,
];
