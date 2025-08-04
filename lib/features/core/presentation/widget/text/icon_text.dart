import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class IconText extends StatefulWidget {
  final String text;
  final dynamic icon;
  final TextStyle? textStyle;
  final double? size;

  const IconText({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
    this.size,
  });

  @override
  State<IconText> createState() => _IconTextState();
}

class _IconTextState extends State<IconText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.icon is SvgGenImage)
          (widget.icon as SvgGenImage).dynamicSVGColor(
            context,
            color: context.appColorSchema.primaryColor,
            width: widget.size ?? 18,
          ),
        if (widget.icon is Widget) widget.icon,
        4.width(),
        Text(
          widget.text,
          style:
              widget.textStyle ??
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.appColorSchema.textColors.primaryText,
              ),
        ),
      ],
    );
  }
}
