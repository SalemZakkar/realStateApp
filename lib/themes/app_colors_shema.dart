import 'package:flutter/material.dart';

part 'colors.dart';

abstract class AppColorsSchema {
  MainColor get primaryColor => MainColor(0xFF008236, {});

  Brightness get brightness;

  TextColors get textColors;

  ShapeColors get shapeColors;

  StatusColors get statusColors =>
      StatusColors(fail: darkCoral, success: Colors.green);

  MainColor white = MainColor(0xffffffff, {});
  MainColor cultured = MainColor(0xfff6f6f6, {});
  MainColor chineseWhite = MainColor(0xffE0E0E0, {});
  MainColor antiFlashWhite = MainColor(0xffF2F5F1, {});
  MainColor ghostWhite = MainColor(0xfff9f9f9, {});
  MainColor black = MainColor(0xff111111, {});
  MainColor darkCoral = MainColor(0xffCD5B3B, {});
  MainColor graniteGrey = MainColor(0xff666666, {});
  MainColor spanishGrey = MainColor(0xff999999, {});
  MainColor brightGray = MainColor(0xffE9EDEC, {});
  MainColor manatee = MainColor(0xff9CA2AA, {});
  Color grey = Colors.grey;
  Color blue = Colors.blue;
}

class LightAppColorSchema extends AppColorsSchema {
  @override
  Brightness get brightness => Brightness.light;

  @override
  ShapeColors get shapeColors => ShapeColors(
    backgroundColor: brightGray,
    dividerColor: chineseWhite,
    cardColor: antiFlashWhite,
    borderColor: chineseWhite,
    appBar: brightGray,
    navBar: antiFlashWhite,
    iconColor: manatee,
  );

  @override
  TextColors get textColors => TextColors(
    primaryText: black,
    labelAndSecondaryText: graniteGrey,
    hintAndDisable: spanishGrey,
  );
}
