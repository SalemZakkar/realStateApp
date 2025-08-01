import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final bool withoutBorder;

  const CustomCardWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.withoutBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: backgroundColor ?? Theme.of(context).cardColor,
      elevation: 0,
      shape: (withoutBorder)
          ? RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            )
          : RoundedRectangleBorder(
              side: BorderSide(
                  color: borderColor ??
                      Theme.of(context).primaryColor.withValues(alpha: 0.1)
                  // ?? Theme.of(context).appColors.grey.tint20!,
                  ),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
      child: Container(
        padding: padding,
        child: child,
      ),
    );
  }
}
