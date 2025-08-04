import 'package:flutter/material.dart';

part 'colors.dart';

abstract class AppColorsSchema {
  MainColor get primaryColor => MainColor(0xFF1F3661, {});

  Brightness get brightness;

  TextColors get textColors;

  ShapeColors get shapeColors;

  StatusColors get statusColors =>
      StatusColors(fail: Colors.red, success: Colors.green);

  MainColor white = MainColor(0xffffffff, {});
  MainColor whiteDarker = MainColor(0xffF3F5F9, {});
  MainColor chineseWhite = MainColor(0xffE0E0E0, {});
  // MainColor antiFlashWhite = MainColor(0xffF2F5F1, {});
  MainColor black = MainColor(0xff111111, {});
  MainColor darkCoral = MainColor(0xffCD5B3B, {});
  MainColor graniteGrey = MainColor(0xff666666, {});
  MainColor spanishGrey = MainColor(0xff999999, {});
  MainColor onyx = MainColor(0xff333539, {});
  // MainColor eireBlack = MainColor(0xff1A1C22, {});
  Color grey = Colors.grey;
  Color blue = Colors.blue;
  final MainColor eireBlack = MainColor(0xFF141821, {});
  final MainColor darkJungleGreen = MainColor(0xFF1C1F27, {});
  final MainColor gunMental = MainColor(0xFF2A2D35, {});
  // final MainColor cadetGrey = MainColor(0xFFFFFFFF, {});
  final MainColor antiFlashWhite = MainColor(0xFFF1F1F1, {});
  final MainColor quickSilver = MainColor(0xFFA1A1AA, {});
  final MainColor blackCoral = MainColor(0xFF5E6572, {});
  final MainColor crayola = MainColor(0xFF2563EB, {});
}

class LightAppColorSchema extends AppColorsSchema {
  @override
  Brightness get brightness => Brightness.light;

  @override
  ShapeColors get shapeColors => ShapeColors(
    backgroundColor: whiteDarker,
    dividerColor: chineseWhite,
    cardColor: white,
    borderColor: chineseWhite,
    appBar: whiteDarker,
    navBar: antiFlashWhite,
    iconColor: onyx,
  );

  @override
  TextColors get textColors => TextColors(
    primaryText: black,
    labelAndSecondaryText: graniteGrey,
    hintAndDisable: spanishGrey,
  );
}

class DarkAppColorSchema extends AppColorsSchema {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  MainColor get primaryColor => crayola;


  @override
  ShapeColors get shapeColors => ShapeColors(
    backgroundColor: eireBlack,
    dividerColor: gunMental,
    cardColor: darkJungleGreen,
    borderColor: gunMental,
    appBar: eireBlack,
    navBar: darkJungleGreen,
    iconColor: white,
  );

  @override
  TextColors get textColors => TextColors(
    primaryText: white,
    labelAndSecondaryText: white,
    hintAndDisable: white,
  );
}
