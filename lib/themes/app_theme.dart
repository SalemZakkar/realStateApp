import 'package:flutter/material.dart';
import 'package:real_state/themes/app_colors_shema.dart';

class AppTheme {
  final AppColorsSchema _schema;

  AppTheme(this._schema);

  ThemeData getThemeData() => ThemeData(
    useMaterial3: true,
    fontFamily: 'cairo',
    brightness: _schema.brightness,
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios_new),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _schema.shapeColors.appBar,
      toolbarHeight: 80,
      centerTitle: false,

      // backgroundColor: _schema.shapeColors.appBar,
    ),
    // progressIndicatorTheme: ProgressIndicatorThemeData(
    //   circularTrackColor: _schema.primaryColor,
    // ),
    primaryColor: _schema.primaryColor,
    scaffoldBackgroundColor: _schema.shapeColors.backgroundColor,
    bottomAppBarTheme: BottomAppBarThemeData(color: _schema.shapeColors.navBar),
    cardColor: _schema.shapeColors.cardColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _schema.shapeColors.navBar,
      selectedIconTheme: IconThemeData(color: _schema.primaryColor),
      selectedItemColor: _schema.primaryColor,
      selectedLabelStyle: TextStyle(color: _schema.primaryColor),
    ),
    iconTheme: IconThemeData(color: _schema.shapeColors.iconColor),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0, // up from 57
        fontWeight: FontWeight.w400,
        letterSpacing: -0.5,
        color: _schema.textColors.primaryText,
      ),
      displayMedium: TextStyle(
        fontSize: 45.0, // up from 45
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: _schema.textColors.primaryText,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0, // up from 36
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.textColors.primaryText,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0, // up from 32
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.textColors.primaryText,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0, // up from 28
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.textColors.primaryText,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0, // up from 24
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.textColors.primaryText,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0, // up from 22
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: _schema.textColors.primaryText,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0, // up from 16
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: _schema.textColors.labelAndSecondaryText,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0, // up from 14
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: _schema.textColors.labelAndSecondaryText,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0, // up from 16
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: _schema.textColors.primaryText,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0, // up from 14
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: _schema.textColors.primaryText,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0, // up from 12
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: _schema.textColors.labelAndSecondaryText,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0, // up from 14
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: _schema.textColors.labelAndSecondaryText,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0, // up from 12
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: _schema.textColors.labelAndSecondaryText,
      ),
      labelSmall: TextStyle(
        fontSize: 11.0, // up from 11
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: _schema.textColors.hintAndDisable,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: _schema.primaryColor,
      brightness: _schema.brightness,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _schema.shapeColors.cardColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: TextStyle(
        color: _schema.textColors.labelAndSecondaryText,
        // fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        color: _schema.textColors.hintAndDisable,
        // fontSize: 13,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _schema.shapeColors.borderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _schema.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _schema.statusColors.fail, width: 1),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _schema.statusColors.fail, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: _schema.shapeColors.borderColor,
          width: 2,
        ),
      ),
      errorStyle: TextStyle(color: _schema.statusColors.fail),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: _schema.primaryColor),
        backgroundColor: _schema.shapeColors.backgroundColor,
        // overlayColor: _schema.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
          side: BorderSide(color: _schema.primaryColor, width: 2),
        ),
        // surfaceTintColor: _schema.blue,
        padding: EdgeInsets.all(8),
        disabledBackgroundColor: Colors.grey,
        textStyle: TextStyle(
          fontFamily: 'cairo',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),

        foregroundColor: _schema.primaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _schema.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        padding: EdgeInsets.all(8),
        disabledBackgroundColor: Colors.grey,
        textStyle: TextStyle(
          fontFamily: 'cairo',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: _schema.white,
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        fontFamily: 'cairo',
        color: _schema.textColors.primaryText,
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _schema.primaryColor,
      thumbColor: _schema.primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 16, fontFamily: 'cairo'),
      ),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16)
    )
  );
}

// extension AppThemeExtension on ThemeData {
//   AppTheme get appTheme => AppTheme(LightAppColorSchema());
// }

extension ContextAppThemeExtension on BuildContext {
  AppColorsSchema get appColorSchema {
    AppColorsSchema schema =
        MediaQuery.of(this).platformBrightness == Brightness.dark
        ? DarkAppColorSchema()
        : LightAppColorSchema();
    return schema;
  }

  ThemeData get theme => AppTheme(appColorSchema).getThemeData();
}

// extension GetAppColorTheme on ThemeData {
//   AppColorsSchema get appColors {
//     return LightAppColorSchema();
//   }
// }
