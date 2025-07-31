import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/page/settings_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_list_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_map_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_saved_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264 + 64,
      height: 72,
      alignment: Alignment.center,

      decoration: BoxDecoration(
        // color: Colors.bl,
        borderRadius: BorderRadius.circular(50),
      ),
      // padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                // color: Colors.bl,
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.withValues(alpha: 0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const SizedBox(),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Button(image: Assets.icons.home, path: RealStateMapPage.path),
                _Button(icon: Icons.menu, path: RealStateListPage.path),
                _Button(
                  image: Assets.icons.star,
                  path: RealStateSavedPage.path,
                ),
                _Button(icon: Icons.settings_outlined, path: SettingsPage.path),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatefulWidget {
  final SvgGenImage? image;
  final IconData? icon;
  final String path;

  const _Button({this.image, required this.path, this.icon});

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> {
  @override
  Widget build(BuildContext context) {
    bool sel = GoRouter.of(context).state.path == widget.path;
    return InkWellWithoutFeedback(
      onTap: () {
        context.go(widget.path);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 56,
        height: 56,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: sel
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
        ),
        child: widget.icon == null
            ? widget.image!.dynamicSVGColor(
                width: 24,
                context,
                color: sel
                    ? context.appColorSchema.white
                    : context.appColorSchema.shapeColors.iconColor,
              )
            : Icon(
                widget.icon!,
                color: sel
                    ? context.appColorSchema.white
                    : context.appColorSchema.shapeColors.iconColor,
              ),
      ),
    );
  }
}
