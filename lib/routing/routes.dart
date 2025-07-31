import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/auth/presentation/page/auth_signup_page.dart';
import 'package:real_state/features/core/domain/enum/otp_reason.dart';
import 'package:real_state/features/core/presentation/page/send_otp_page.dart';
import 'package:real_state/features/core/presentation/page/splash_page.dart';
import 'package:real_state/features/core/presentation/page/verify_otp_page.dart';
import 'package:real_state/features/home/presentation/home_page.dart';
import 'package:real_state/features/user/presentation/user_change_password_page.dart';
import 'package:real_state/routing/route_info.dart';

class Routes {
  Routes._();

  static Routes I = Routes._();

  final List<RouteInfo> routes = [
    RouteInfo(
      path: SplashPage.path,
      builder: (context, state, child) => SplashPage(),
    ),
    RouteInfo(path: HomePage.path, builder: (co, st, _) => HomePage()),
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
      builder: (context, state, child) => SendOtpPage(reason: state.extra as OtpReason),
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
