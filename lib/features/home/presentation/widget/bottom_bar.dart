import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/page/settings_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/home/presentation/page/home_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_list_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_map_page.dart';
import 'package:real_state/features/user/presentation/page/profile_page.dart';
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
      constraints: BoxConstraints(
        maxWidth: 320
      ),
      height: 64,
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
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(
                        context,
                      ).scaffoldBackgroundColor.withValues(alpha: 0.6)
                    : Theme.of(context).primaryColor.withValues(alpha: 0.3),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: const SizedBox(),
              ),
            ),
          ),
          Positioned(
            left: 4,
            right: 4,
            bottom: 0,
            top: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Button(
                  image: Assets.icons.compass,
                  path: RealStateMapPage.path,
                ),
                _Button(
                  image: Assets.icons.building,
                  path: RealStateListPage.path,
                ),
                _Button(image: Assets.icons.home, path: HomePage.path),
                _Button(
                  image: Assets.icons.user,
                  path: ProfilePage.path,
                ),
                _Button(image: Assets.icons.info, path: SettingsPage.path),
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
        width: 48,
        height: 48,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: sel
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
        ),
        child: widget.icon == null
            ? widget.image!.dynamicSVGColor(
                width: 30,
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
