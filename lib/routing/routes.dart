import 'package:core_package/core_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_state/features/auth/presentation/page/auth_login_page.dart';
import 'package:real_state/features/auth/presentation/page/auth_otp_page.dart';
import 'package:real_state/features/core/presentation/page/legal_page.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/page/settings_page.dart';
import 'package:real_state/features/core/presentation/page/splash_page.dart';
import 'package:real_state/features/core/presentation/page/update_app_page.dart';
import 'package:real_state/features/core/presentation/page/view_image_page.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';
import 'package:real_state/features/home/presentation/page/main_page.dart';
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
        // RouteInfo(
        //   useRootNavigator: false,
        //   path: RealEStateListPage.path,
        //   builder: (context, state, child) => RealEStateListPage(
        //     params: state.extra as RealEstateListPageParams?,
        //   ),
        // ),
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

        RouteInfo(
          useRootNavigator: false,
          path: SettingsPage.path,
          builder: (context, state, child) => SettingsPage(),
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
    // RouteInfo(
    //   path: RealEstateDetailsPage.path,
    //   builder: (context, state, child) =>
    //       RealEstateDetailsPage(realEstate: state.extra as RealEstate),
    // ),
    RouteInfo(
      path: MapPage.path,
      builder: (context, state, child) =>
          MapPage(latLng: state.extra as LatLng),
    ),
    // RouteInfo(
    //   path: RealEstateFilterPage.path,
    //   builder: (context, state, child) => RealEstateFilterPage(
    //     params: state.extra as RealEstateFilterPageParams,
    //   ),
    // ),
    RouteInfo(builder: (c, s, i) => UpdateAppPage(), path: UpdateAppPage.path),
    RouteInfo(
      builder: (c, s, i) => ViewImagePage(url: s.extra as String),
      path: ViewImagePage.path,
    ),
    // RouteInfo(
    //   path: RealEstateFormPage.path,
    //   builder: (context, state, child) =>
    //       RealEstateFormPage(realEstate: state.extra as RealEstate?),
    // ),
    // RouteInfo(
    //   builder: (context, state, child) =>
    //       RealEstateImagePage(realEstate: state.extra as RealEstate),
    //
    //   path: RealEstateImagePage.path,
    // ),
    // RouteInfo(
    //   path: RealEStateListPage.extPath,
    //   builder: (context, state, child) =>
    //       RealEStateListPage(params: state.extra as RealEstateListPageParams?),
    // ),
    // RouteInfo(
    //   path: TutorialPage.path,
    //   builder: (context, state, child) => TutorialPage(),
    // ),
    RouteInfo(
      builder: (context, state, child) => LegalPage(),
      path: LegalPage.path,
    ),
    RouteInfo(
      builder: (context, state, child) => UserBlockedPage(),
      path: UserBlockedPage.path,
    ),
    RouteInfo(
      builder: (context, state, child) => UserCompleteProfilePage(),
      path: UserCompleteProfilePage.path,
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
  // RealEStateListPage.path,
  // RealEStateMapPage.path,
  ProfilePage.path,
  SettingsPage.path,
  HomePage.path,
];
