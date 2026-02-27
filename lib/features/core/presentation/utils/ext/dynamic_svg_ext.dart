import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

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
    Alignment? alignment,
  }) {
    return _dynamicSVGColor(
      path,
      context,
      height: height,
      width: width,
      color: color,
      package: package,
      alignment: alignment,
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
  Alignment? alignment,
}) {
  return SvgPicture.asset(
    path,
    package: package,
    width: width,

    alignment: alignment ?? Alignment.center,
    height: height,
    colorFilter: ColorFilter.mode(
      color ?? Theme.of(context).iconTheme.color ?? Colors.black,
      BlendMode.srcIn,
    ),
  );
}
