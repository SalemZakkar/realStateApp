import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_state/themes/app_theme.dart';

import '../../../../../generated/generated_assets/assets.gen.dart';

extension DynamicSVGImageColor on String {
  SvgPicture dynamicSVGColor(
    BuildContext context, {
    String? package,
    double? width,
    double? height,
    Color? color,
  }) {
    return _dynamicSVGColor(
      this,
      context,
      height: height,
      width: width,
      color: color,
      package: package,
    );
  }
}

extension DynamicSVGImageColor2 on SvgGenImage {
  SvgPicture dynamicSVGColor(
    BuildContext context, {
    String? package,
    double? width,
    double? height,
    Color? color,
  }) {
    return _dynamicSVGColor(
      path,
      context,
      height: height,
      width: width,
      color: color,
      package: package,
    );
  }
}

SvgPicture _dynamicSVGColor(
  String path,
  BuildContext context, {
  String? package,
  double? width,
  double? height,
  Color? color,
}) {
  return SvgPicture.asset(
    path,
    package: package,
    width: width,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? context.appColorSchema.shapeColors.iconColor,
      BlendMode.srcIn,
    ),
  );
}
