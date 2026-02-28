import 'package:core_package/core_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/auth/presentation/page/auth_otp_page.dart';
import 'package:real_state/features/core/presentation/page/legal_page.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/page/about_us_page.dart';
import 'package:real_state/features/core/presentation/page/splash_page.dart';
import 'package:real_state/features/core/presentation/page/update_app_page.dart';
import 'package:real_state/features/core/presentation/page/view_image_page.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';
import 'package:real_state/features/home/presentation/page/main_page.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/presentation/page/properties_details_page.dart';
import 'package:real_state/features/properties/presentation/page/property_images_page.dart';
import 'package:real_state/features/properties/presentation/page/property_list_page.dart';
import 'package:real_state/features/user/presentation/page/profile_page.dart';
import 'package:real_state/features/user/presentation/page/user_blocked_page.dart';
import 'package:real_state/features/user/presentation/page/user_complete_profile_page.dart';
import 'package:real_state/routing/route_info.dart';

class Routes {
  Routes._();

  static Routes I = Routes._();

  final List<RouteInfo> routes = [
    RouteInfo(
      path: SplashPage.path,
      builder: (context, state, child) => SplashPage(),
    ),
    RouteInfo(
      path: MainPage.path,
      type: RouteType.shell,
      builder: (co, st, child) => MainPage(child: child!),
      routes: [
        // RouteInfo(
        //   useRootNavigator: false,
        //   path: RealEStateMapPage.path,
        //   builder: (context, state, child) => RealEStateMapPage(),
        // ),
        RouteInfo(
          useRootNavigator: false,
          path: PropertyListPage.shell,
          builder: (context, state, child) =>
              PropertyListPage(params: state.extra as PropertyGetParams?),
        ),
        RouteInfo(
          useRootNavigator: false,
          path: HomePage.path,
          builder: (context, state, child) => HomePage(),
        ),
        RouteInfo(
          useRootNavigator: false,
          builder: (c, s, i) => ProfilePage(),
          path: ProfilePage.path,
        ),
      ],
    ),
    RouteInfo(
      path: AuthLoginPage.path,
      builder: (context, state, child) =>
          AuthLoginPage(withBack: state.extra as bool?),
    ),
    RouteInfo(
      path: AuthOtpPage.path,
      builder: (context, state, child) =>
          AuthOtpPage(phone: state.extra!.toString()),
    ),
    RouteInfo(
      path: MapPage.path,
      builder: (context, state, child) =>
          MapPage(latLng: state.extra as LatLng),
    ),
    RouteInfo(builder: (c, s, i) => UpdateAppPage(), path: UpdateAppPage.path),
    RouteInfo(
      builder: (c, s, i) => ViewImagePage(url: s.extra as String),
      path: ViewImagePage.path,
    ),
    RouteInfo(
      builder: (context, state, child) => UserBlockedPage(),
      path: UserBlockedPage.path,
    ),
    RouteInfo(
      builder: (context, state, child) => UserCompleteProfilePage(),
      path: UserCompleteProfilePage.path,
    ),
    RouteInfo(
      builder: (context, state, child) => LegalPage(type: state.extra as int),
      path: LegalPage.path,
    ),
    RouteInfo(
      builder: (context, state, child) =>
          PropertyListPage(params: state.extra as PropertyGetParams?),
      path: PropertyListPage.path,
    ),
    RouteInfo(
      builder: (context, state, child) =>
          PropertyDetailsPage(id: state.extra!.toString()),
      path: PropertyDetailsPage.path,
    ),
    RouteInfo(
      builder: (context, state, child) =>
          PropertyImagesPage(property: state.extra as Property),
      path: PropertyImagesPage.path,
    ),

    RouteInfo(
      path: AboutUsPage.path,
      builder: (context, state, child) => AboutUsPage(),
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
  PropertyListPage.shell,
  // RealEStateMapPage.path,
  ProfilePage.path,
  // AboutUsPage.path,
  HomePage.path,
];
