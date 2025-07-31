// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontGen {
  const $AssetsFontGen();

  /// File path: assets/font/Cairo-Black.ttf
  String get cairoBlack => 'assets/font/Cairo-Black.ttf';

  /// File path: assets/font/Cairo-Bold.ttf
  String get cairoBold => 'assets/font/Cairo-Bold.ttf';

  /// File path: assets/font/Cairo-ExtraBold.ttf
  String get cairoExtraBold => 'assets/font/Cairo-ExtraBold.ttf';

  /// File path: assets/font/Cairo-ExtraLight.ttf
  String get cairoExtraLight => 'assets/font/Cairo-ExtraLight.ttf';

  /// File path: assets/font/Cairo-Light.ttf
  String get cairoLight => 'assets/font/Cairo-Light.ttf';

  /// File path: assets/font/Cairo-Medium.ttf
  String get cairoMedium => 'assets/font/Cairo-Medium.ttf';

  /// File path: assets/font/Cairo-Regular.ttf
  String get cairoRegular => 'assets/font/Cairo-Regular.ttf';

  /// File path: assets/font/Cairo-SemiBold.ttf
  String get cairoSemiBold => 'assets/font/Cairo-SemiBold.ttf';

  /// File path: assets/font/calibri.ttf
  String get calibri => 'assets/font/calibri.ttf';

  /// List of all assets
  List<String> get values => [
    cairoBlack,
    cairoBold,
    cairoExtraBold,
    cairoExtraLight,
    cairoLight,
    cairoMedium,
    cairoRegular,
    cairoSemiBold,
    calibri,
  ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/email.svg
  SvgGenImage get email => const SvgGenImage('assets/icons/email.svg');

  /// File path: assets/icons/invisible.svg
  SvgGenImage get invisible => const SvgGenImage('assets/icons/invisible.svg');

  /// File path: assets/icons/name.svg
  SvgGenImage get name => const SvgGenImage('assets/icons/name.svg');

  /// File path: assets/icons/otp.svg
  SvgGenImage get otp => const SvgGenImage('assets/icons/otp.svg');

  /// File path: assets/icons/password.svg
  SvgGenImage get password => const SvgGenImage('assets/icons/password.svg');

  /// File path: assets/icons/phone.svg
  SvgGenImage get phone => const SvgGenImage('assets/icons/phone.svg');

  /// File path: assets/icons/visible.svg
  SvgGenImage get visible => const SvgGenImage('assets/icons/visible.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    email,
    invisible,
    name,
    otp,
    password,
    phone,
    visible,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontGen font = $AssetsFontGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
