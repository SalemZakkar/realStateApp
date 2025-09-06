import 'package:flutter/material.dart';

part 'colors.dart';

abstract class AppColorsSchema {
  MainColor get primaryColor => crayola;

  Brightness get brightness;

  TextColors get textColors;

  ShapeColors get shapeColors;

  ShadowColors get shadowColors;

  Shadows get shadows;

  StatusColors get statusColors => StatusColors(
    fail: Colors.red,
    success: Colors.green,
    pending: Colors.orange,
  );
  MainColor white = MainColor(0xffffffff, {});
  MainColor whiteDarker = MainColor(0xffF3F5F9, {});
  MainColor chineseWhite = MainColor(0xffE0E0E0, {});
  MainColor black = MainColor(0xff111111, {});
  MainColor darkCoral = MainColor(0xffCD5B3B, {});
  MainColor graniteGrey = MainColor(0xff666666, {});
  MainColor spanishGrey = MainColor(0xff999999, {});
  MainColor onyx = MainColor(0xff333539, {});
  Color grey = Colors.grey;
  Color blue = Colors.blue;
  final MainColor eireBlack = MainColor(0xFF191919, {});
  final MainColor darkJungleGreen = MainColor(0xFF1C1F27, {});
  final MainColor gunMental = MainColor(0xFF2A2D35, {});
  final MainColor antiFlashWhite = MainColor(0xFFF1F1F1, {});
  final MainColor quickSilver = MainColor(0xFFA1A1AA, {});
  final MainColor blackCoral = MainColor(0xFF5E6572, {});
  final MainColor crayola = MainColor(0xFF2563EB, {});
  final MainColor richBlack = MainColor(0xFF010507, {});
  final MainColor cultured = MainColor(0xFFF3F5F9, {});
  final MainColor gold = MainColor(0xffB8860B, {});
}

class LightAppColorSchema extends AppColorsSchema {
  @override
  Brightness get brightness => Brightness.light;

  @override
  ShapeColors get shapeColors => ShapeColors(
    backgroundColor: cultured,
    dividerColor: chineseWhite,
    cardColor: white,
    borderColor: chineseWhite,
    appBar: cultured,
    navBar: antiFlashWhite,
    iconColor: onyx,
  );

  @override
  TextColors get textColors => TextColors(
    primaryText: black,
    labelAndSecondaryText: graniteGrey,
    hintAndDisable: spanishGrey,
  );

  @override
  ShadowColors get shadowColors => ShadowColors(mainShadow: Colors.grey[200]!);

  @override
  Shadows get shadows => Shadows(
    cardShadow: BoxShadow(
      color: shadowColors.mainShadow,
      blurRadius: 4,
      spreadRadius: 3,
    ),
  );
}

class DarkAppColorSchema extends AppColorsSchema {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  MainColor get primaryColor => crayola;

  @override
  ShapeColors get shapeColors => ShapeColors(
    backgroundColor: richBlack,
    dividerColor: gunMental,
    cardColor: eireBlack,
    borderColor: gunMental,
    appBar: richBlack,
    navBar: darkJungleGreen,
    iconColor: white,
  );

  @override
  TextColors get textColors => TextColors(
    primaryText: white,
    labelAndSecondaryText: white,
    hintAndDisable: graniteGrey,
  );

  @override
  ShadowColors get shadowColors =>
      ShadowColors(mainShadow: MainColor(Colors.transparent.toARGB32(), {}));

  @override
  Shadows get shadows =>
      Shadows(cardShadow: BoxShadow(color: shadowColors.mainShadow));
}
