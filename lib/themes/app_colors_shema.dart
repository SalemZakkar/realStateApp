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
  // MainColor whiteDark = MainColor(0xffFEFEFE, {});
  MainColor whiteDarker = MainColor(0xffF3F5F9, {});
  // MainColor cultured = MainColor(0xfff6f6f6, {});
  MainColor chineseWhite = MainColor(0xffE0E0E0, {});
  MainColor antiFlashWhite = MainColor(0xffF2F5F1, {});
  // MainColor ghostWhite = MainColor(0xfff9f9f9, {});
  MainColor black = MainColor(0xff111111, {});
  MainColor darkCoral = MainColor(0xffCD5B3B, {});
  MainColor graniteGrey = MainColor(0xff666666, {});
  MainColor spanishGrey = MainColor(0xff999999, {});
  // MainColor brightGray = MainColor(0xffE9EDEC, {});
  MainColor onyx = MainColor(0xff333539, {});
  MainColor eireBlack = MainColor(0xff1A1C22, {});
  Color grey = Colors.grey;
  Color blue = Colors.blue;
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
